# PaymentsWorker
class PaymentsWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  # perform worker
  def perform(contribution_id)
    contribution = Contribution.find(contribution_id)
    contribution.complete_payment
  end
end
