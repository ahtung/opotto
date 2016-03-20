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

  # Complete preapproved payments to receivers
  def complete_payment
    api.execute :Pay, payment_options(preapproval_key)
    payment_info
  end

  private

  # Setup the Payment and return pay object
  def setup_preapproval
    api.execute :Preapproval, preapproval_payment_options
  end

  # describe
  def update_payment_details(payment)
    if payment.success?
      self.authorization_url = api.preapproval_url(payment)
      update_column(:preapproval_key, payment.preapproval_key)
    end
    Rails.logger.info("Payment log | Payment updated details with the payment key: #{payment.preapproval_key} in #{payment_time / 60} minutes")
  end

  # Retrieve Data about the Payment
  def payment_info
    response = api.execute(:PaymentDetails, pay_key: preapproval_key)
    parse_payment_info(response)
  end

  # Pare payment info
  def parse_payment_info(response)
    if response.success?
      self.user = User.find_by(email: response.sender.email)
      success! if scheduled?
      Rails.logger.info "Payment log |  Payment completed for #{payment_options(preapproval_key)}"
    else
      error! if scheduled?
      Rails.logger.error "Payment log |  Payment completed for #{payment_options(preapproval_key)}"
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
      ending_date: jar.end_at.utc,
      starting_date: Time.now.utc,
      senderEmail: user.email,
      currency_code: amount.currency.iso_code,
      return_url: Rails.application.routes.url_helpers.payments_success_url(contribution: id),
      cancel_url: Rails.application.routes.url_helpers.payments_failure_url(contribution: id),
      feesPayer: 'PRIMARYRECEIVER'
    }
  end

  # list of receivers for initial paypal payment
  def payment_receivers
    [
      { email: ENV['PAYPAL_EMAIL'], amount: (amount.to_f * ENV['WIN'].to_f) },
      { email: jar.receiver.email, amount: amount.to_f, primary: true }
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
