# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds
  # validate :preapproval_initiated, unless: 'Rails.env.test?'

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

  attr_accessor :authorization_url

  after_create :get_authorization_url

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
            email: 'dunyakirkali-buyer@yahoo.fr',
            amount: amount * (1.0 - ENV['WIN'].to_f),
            primary: false },
          {
            email: ENV['PAYPAL_EMAIL'],
            amount: amount * ENV['WIN'].to_f,
            primary: true
          }
        ]
      }
    }
  end

  def get_authorization_url
    pay = api.build_pay(payment_options)
    response = api.pay(pay)
    result = response.responseEnvelope.ack == "Success"
    if result
      update_attribute(:authorization_url, api.payment_url(response))
      PaymentsWorker.perform_in((jar.end_at - Time.zone.now), id)
      Rails.logger.info authorization_url
    else
      error_message = response.error[0].message
      # errors.add(:base, error_message)
      Rails.logger.error response
      Rails.logger.error error_message
    end
  end

  def api
    @api ||= PayPal::SDK::AdaptivePayments::API.new
  end
end
