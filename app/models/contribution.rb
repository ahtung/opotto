# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds
  validate :preapproval_initiated, unless: 'Rails.env.test?'

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

  attr_accessor :authorization_url

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

  # Validates successfull preaaproval initiation
  def preapproval_initiated
    return true if payment_key
    initiate_preapproval
  end

  # Initiates a chained payment
  def initiate_preapproval
    api = PayPal::SDK::AdaptivePayments::API.new
    preapproval = api.build_preapproval(payment_options)
    response = api.preapproval(preapproval)
    result = response.responseEnvelope.ack == "Success"
    if result
      self.preapproval_key = response.preapprovalKey
      self.authorization_url = "#{ENV['PAYPAL_AUTHORIZATION_URL']}#{self.preapproval_key}"
      Rails.logger.info preapproval_key
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
      returnUrl:       Rails.application.routes.url_helpers.payments_success_url,
      cancelUrl:       Rails.application.routes.url_helpers.payments_failure_url,
      startingDate:    Time.now.utc,
      endingDate:      jar.end_at.utc,
      currencyCode:    amount.currency

    }
  end
end
