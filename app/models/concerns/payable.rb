# Payable
module Payable
  extend ActiveSupport::Concern

  included do
    # Callbacks
    after_create :pay
  end

  # start the paypal payment
  def pay
    response = setup_preapproval
    return unless response
    update_payment_details(response)
  end

  # returns the payment time
  def payment_time
    jar.end_at - Time.zone.now
  end

  private

  # Setup the Payment and return pay object
  def setup_preapproval
    api.execute :Preapproval, preapproval_payment_options
  end

  # Make preapproved payments to receivers
  def make_preapproved_payments
    api.execute :Pay, payment_options(preapproval_key)
    payment_info
  end

  # describe
  def update_payment_details(payment)
    self.authorization_url = api.payment_url(payment)
    update_column(:payment_key, payment.pay_key)
    Rails.logger.info("Payment log | Payment updated details with the payment key: #{payment.pay_key} in #{payment_time / 60} minutes")
  end

  # Retrieve Data about the Payment
  def payment_info
    response = api.execute(:PaymentDetails, pay_key: payment_key)
    parse_payment_info(response)
  end

  # Pare payment info
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

  # Set payment options when payment triggered
  def payment_options(preapproval_key)
    {
      preapproval_key: preapproval_key,
      action_type:    'PAY',
      currency_code:  amount.currency.iso_code,
      receivers: payment_receivers
    }
  end

  # Set options for setting up preapproval payment
  def preapproval_payment_options
    {
      ending_date: self.jar.end_at,
      starting_date: DateTime.now,
      senderEmail: self.user.email,
      currency_code: amount.currency.iso_code,
      return_url: Rails.application.routes.url_helpers.payments_success_url(contribution: id),
      cancel_url: Rails.application.routes.url_helpers.payments_failure_url(contribution: id),
      feesPayer: 'PRIMARYRECEIVER'
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
end
