namespace :paypal do
  desc 'Updates Users\' Paypal status'
  task update: :environment do
    users_ids = User.where(paypal_member: nil).limit(100).pluck(:id)
    PayPalChecker.perform_async(users_ids)
  end
end

