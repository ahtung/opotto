# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

  validate :payment_succeeded

  attr_accessor :payment_url

  # Returns the proper user name
  def owner_name
    if anonymous?
      'N/A'
    elsif !user.name
      user.email
    else
      user.name
    end
  end

  private

  # Validates payment is inside bounds
  def amount_inside_the_pot_bounds
    return true unless jar.upper_bound
    return true if amount <= jar.upper_bound
    errors.add(:amount,:amount_out_of_bounds)
  end

  # Validates successfull payment
  def payment_succeeded
    return true if payment_url
    initiate_payment
  end

  def initiate_payment
    api = PayPal::SDK::AdaptivePayments.new
    pay = api.build_pay(payment_options)
    response = api.pay(pay)
    result = response.success? && response.payment_exec_status != 'ERROR'
    if result
      response.payKey
      self.payment_url = api.payment_url(response)
      puts payment_url
    else
      puts response.error[0].message
      errors.add(:base, response.error[0].message)
    end
    result
  end

  # Returns ayment options hash
  def payment_options
    {
      actionType:         'PAY',
      cancelUrl:          'http://localhost:3000/samples/adaptive_payments/pay',
      currencyCode:       'USD',
      feesPayer:          'SENDER',
      ipnNotificationUrl: 'http://localhost:3000/samples/adaptive_payments/ipn_notify',
      receiverList: {
        receiver: [
          {
            amount:       1.0,
            email:        'platfo_1255612361_per@gmail.com'
          }
        ]
      },
      returnUrl:          'http://localhost:3000/samples/adaptive_payments/pay'
    }
  end
end
