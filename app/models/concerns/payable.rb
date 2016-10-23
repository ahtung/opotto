# Payable
module Payable
  extend ActiveSupport::Concern

  included do
    # Callbacks
    after_create :pay
  end

  # completes payment
  def complete_payment
  end

  # start the payment
  def pay
    response = nil
    return unless response
    update_payment_details(response)
  end

  # returns the payment time
  def payment_time
    pot.end_at - Time.zone.now
  end

  private

  # describe
  def update_payment_details(payment)
    self.authorization_url = api.preapproval_url(payment) if payment.success?
    Rails.logger.info("Payment log | Payment updated details in #{payment_time / 60} minutes")
  end

  # Retrieve Data about the Payment
  def payment_info(pay_key)
    response = api.execute(:PaymentDetails, pay_key: pay_key)
    Rails.logger.info "Payment log |  Payment details for #{response.inspect}"
    parse_payment_info(response)
  end

  # Validates payment is inside bounds
  def amount_inside_the_pot_bounds
    return if pot.nil?
    return true if pot.upper_bound.nil?
    return true if amount <= pot.upper_bound
    errors.add(:amount, :amount_out_of_bounds)
    false
  end
end
