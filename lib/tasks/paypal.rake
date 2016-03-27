namespace :paypal do
  desc 'Updates Users\' Paypal status'
  task update: :environment do
    users_ids = User.where(paypal_member: nil).limit(100).pluck(:id)
    PayPalChecker.perform_async(users_ids)
  end

  desc 'Pays Users\' contributions'
  task pay: :environment do
    contributions_ids = Contribution.with_state(:scheduled).payable.limit(100).pluck(:id)
    PaymentsWorker.perform_async(contributions_ids)
  end
end
