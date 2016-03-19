# Payable
module Payable
  extend ActiveSupport::Concern

  included do
    # Callbacks
    after_create :pay
  end

  # start the paypal payment
  def pay
    preapproval = setup_preapproval
    response = redirect_to_paypal(preapproval)
    return unless response
    update_payment_details(response)
    payment_info
  end

  # returns the payment time
  def payment_time
    jar.end_at - Time.zone.now
  end

  # Completes payment (pay secondary receiver)
  def complete_payment
    api.execute :ExecutePayment, secondary_payment_options do |response|
      if response.success?
        success! if scheduled?
        Rails.logger.info "Payment log |  Payment completed for #{secondary_payment_options}"
      else
        error! if scheduled?
        Rails.logger.error "Payment log |  Payment completed for #{secondary_payment_options}"
      end
    end
  end

  private


  # Setup the Payment and return pay object
  def setup_preapproval
    api.execute :Preapproval, preapproval_payment_options
  end

  # Redirect the Customer to PayPal for Authorization and return response
  def redirect_to_paypal(response)
    if response.success?
      p "Pay key: #{response.preapproval_key}".green
      Launchy.open(api.preapproval_url(response))
    else
      p "#{response.ack_code}: #{response.error_message}".red
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
    return if jar.nil?
    return true if jar.upper_bound.nil?
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
      return_url: Rails.application.routes.url_helpers.payments_success_url(contribution: id),
      cancel_url: Rails.application.routes.url_helpers.payments_failure_url(contribution: id),
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
      sandbox: !Rails.env.production?,
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
