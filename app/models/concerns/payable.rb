# Payable
module Payable
  extend ActiveSupport::Concern

  included do
    # Callbacks
    after_commit :pay, on: :create
  end

  # start the paypal payment
  def pay
    response = initiate_payment
    return unless response
    update_payment_details(response)
    payment_info
    PaymentsWorker.perform_in(payment_time, id)
  end

  # completes the paypal payment
  def complete
    if complete_payment
      success!
    else
      fail!
    end
  end

  # Refunds payment
  def refund_payment
  end

  # returns the payment time
  def payment_time
    jar.end_at - Time.zone.now
  end

  private

  # Completes payment (pay secondary receiver)
  def complete_payment
    api.execute :ExecutePayment, secondary_payment_options do |response|
      if response.success?
        Rails.logger.info "Payment log |  Payment completed for #{secondary_payment_options}"
      else
        Rails.logger.error "Payment log |  Payment completed for #{secondary_payment_options}"
      end
    end
  end

  # Initiates a payment
  def initiate_payment
    api.execute :Pay, payment_options do |response|
      if response.success?
        Rails.logger.info "Payment log |  Payment initiated for #{payment_options}"
      else
        Rails.logger.error "Payment log |  Payment initiated for #{payment_options}"
      end
    end
  end

  # describe
  def update_payment_details(payment)
    self.authorization_url = api.payment_url(payment)
    update_column(:payment_key, payment.pay_key)
    Rails.logger.info("Payment log | Payment updated details with the payment key: #{payment.pay_key} in #{payment_time / 60} minutes")
  end

  # describe
  def payment_info
    response = api.execute(:PaymentDetails, pay_key: payment_key)
    parse_payment_info(response)
  end

  def parse_payment_info(response)
    if response.success?
      self.user = User.find_by(email: response.sender.email)
      Rails.logger.info "Payment log |  Payment got info #{response.sender.email}"
    else
      Rails.logger.error "Payment log |  Payment failed getting info #{response.ack_code}: #{response.error_message}"
    end
  end

  # Validates payment is inside bounds
  def amount_inside_the_pot_bounds
    return true unless jar.upper_bound
    return true if amount <= jar.upper_bound
    errors.add(:amount, :amount_out_of_bounds)
    false
  end

  # payment options for initial paypal payment
  def payment_options
    {
      action_type: 'PAY_PRIMARY',
      currency_code: amount.currency.iso_code,
      fees_payer: ENV['PAYPAL_FEESPAYER'],
      return_url: Rails.application.routes.url_helpers.payments_success_url,
      cancel_url: Rails.application.routes.url_helpers.payments_failure_url,
      receivers: payment_receivers
    }
  end

  # list of receivers for initial paypal payment
  def payment_receivers
    [
      { email: ENV['PAYPAL_EMAIL'], amount: amount.to_f, primary: true },
      { email: jar.receiver.email, amount: amount.to_f - (amount.to_f * ENV['WIN'].to_f) }
    ]
  end

  # paypal api
  def api
    @api ||= AdaptivePayments::Client.new(
      sandbox: true,
      app_id: ENV['PAYPAL_APP_ID'],
      user_id: ENV['PAYPAL_USER'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )
  end

  # payment options for secondary paypal payment
  def secondary_payment_options
    {
      action_type: 'PAY',
      pay_key: payment_key
    }
  end
end
