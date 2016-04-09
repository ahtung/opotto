namespace :paypal do
  desc 'Updates Users\' Paypal status'
  task update: :environment do
    users_ids = User.where(paypal_member: nil).limit(100).pluck(:id)
    PayPalChecker.perform_async(users_ids)
  end

  desc 'Pays Users\' contributions'
  task pay: :environment do
    contribution_ids = Contribution.with_state(:scheduled).payable.limit(100).pluck(:id)
    PaymentsWorker.perform_async(contribution_ids)
  end

  desc 'Pays a contribution by id'
  task :manual, [:id] => :environment do |task, args|
    PaymentsWorker.perform_async(args[:id])
  end
end
