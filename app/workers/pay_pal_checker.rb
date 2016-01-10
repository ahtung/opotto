# PayPalChecker
class PayPalChecker
  include Sidekiq::Worker

  sidekiq_options retry: false
  sidekiq_options queue: "paypal_checker"

  # perform worker
  def perform(user_id)
    user = User.find(user_id)
    user.check_paypal
  end
end
