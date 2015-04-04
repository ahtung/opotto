# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds

  after_commit :pay, on: :create
  attr_accessor :authorization_url

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

  # Returns the proper user name
  def owner_name
    if anonymous? || user.nil?
      'N/A'
    else
      user.handle
    end
  end

  # start the paypal payment
  def pay
    if response = initiate_payment
      update_payment_details(response)
      get_payment_info
      PaymentsWorker.perform_in(payment_time, id)
    end
  end

  # completes the paypal payment
  def complete
    if complete_payment
      update_column(:status, 'completed')
    else
      update_column(:status, 'failed')
    end
  end

  # Refunds payment
  def refund_payment
  end

  # returns the payment time
  def payment_time
    jar.end_at - Time.zone.now
  end

  # class methods
  class << self
    # scope for completed contibutions
    def completed
      where(status: 'completed')
    end
  end

  private

  # TODO (dunyakirkali) efactor payment code to class
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
  def get_payment_info
    api.execute(:PaymentDetails, pay_key: payment_key) do |response|
      if response.success?
        self.user = User.where(email: response.sender.email).first
        Rails.logger.info "Payment log |  Payment got info #{response.sender.email}"
      else
        Rails.logger.error "Payment log |  Payment failed getting info #{response.ack_code}: #{response.error_message}"
      end
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
