# PaymentsWorker
class PaymentsWorker
  include Sidekiq::Worker

  sidekiq_options retry: false
  sidekiq_options queue: 'payments'

  # perform worker
  def perform(contribution_ids)
    contributions = Contribution.where(id: contribution_ids)
    contributions.each(&:complete_payment)
  end
end
