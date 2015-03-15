# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds
  validate :payment_initiated, unless: 'Rails.env.test?'

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

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

  # Validates successfull payment initiation
  def payment_initiated
    return true if payment_key
    initiate_payment
  end

  # Initiates a chained payment
  def initiate_payment
    api = PayPal::SDK::AdaptivePayments.new
    pay = api.build_pay(payment_options)
    response = api.pay(pay)
    result = response.success? && response.payment_exec_status != 'ERROR'
    if result
      self.payment_key = response.payKey
      self.payment_url = api.payment_url(response)
      Rails.logger.info payment_url
    else
      error_message = response.error[0].message
      errors.add(:base, error_message)
      Rails.logger.error error_message
    end
    result
  end

  # Returns payment options hash
  def payment_options
    {
      actionType:      'PAY_PRIMARY',
      cancelUrl:       Rails.application.routes.url_helpers.payments_failure_url,
      currencyCode:    amount.currency,
      feesPayer:       ENV['PAYPAL_FEESPAYER'],
      receiverList: {
        receiver: [
          {
            amount:    amount / 100 * ENV['WIN'].to_f,
            email:     ENV['PAYPAL_SANDBOX_EMAIL'],
            primary:   false
          },
          {
            amount:    amount / 100 * (1.0 - ENV['WIN'].to_f),
            email:     jar.receiver.email,
            primary:   true
          }
        ]
      },
      returnUrl:       Rails.application.routes.url_helpers.payments_success_url
    }
  end
end
