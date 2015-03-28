# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds
  # validate :preapproval_initiated, unless: 'Rails.env.test?'

  after_create :initiate_payment
  attr_accessor :authorization_url

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

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

  def complete_payment
    api.execute :ExecutePayment, secondary_payment_options
  end

  def refubd_payment

  end

  private

  # Initiates a payment
  def initiate_payment
    payment = api.execute :Pay, payment_options
    self.authorization_url = api.payment_url(payment)
    self.payment_key = payment.pay_key
    PaymentsWorker.perform_in((jar.end_at - Time.zone.now), id)
  end

  # Validates payment is inside bounds
  def amount_inside_the_pot_bounds
    return true unless jar.upper_bound
    return true if amount <= jar.upper_bound
    errors.add(:amount, :amount_out_of_bounds)
    false
  end

  def payment_options
    {
      action_type:     "PAY_PRIMARY",
      currency_code:   "USD",
      returnUrl:       Rails.application.routes.url_helpers.payments_success_url,
      cancelUrl:       Rails.application.routes.url_helpers.payments_failure_url,
      receiverList: {
        receiver:       [
          {
            email: jar.receiver.email,
            amount: amount - ( amount * ENV['WIN'].to_f ),
            primary: false
          },
          {
            email: ENV['PAYPAL_EMAIL'],
            amount: amount,
            primary: true
          }
        ]
      }
    }
  end

  def api
    @api ||= AdaptivePayments::Client.new(
      sandbox: true,
      app_id: ENV['PAYPAL_APP_ID'],
      user_id: ENV['PAYPAL_EMAIL'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )
  end

  def secondary_payment_options
    {
      action_type: 'PAY',
      pay_key: payment_key
    }
  end
end
