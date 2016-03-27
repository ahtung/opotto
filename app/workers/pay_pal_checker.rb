# PayPalChecker
class PayPalChecker
  include Sidekiq::Worker

  sidekiq_options retry: false
  sidekiq_options queue: 'paypal_checker'

  # perform worker
  def perform(users_ids)
    users = User.where(id: users_ids)
    users.each do |user|
      user.check_paypal
    end
  end
end
