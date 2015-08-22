require 'rails_helper'

RSpec.describe PaymentsWorker, type: :worker do
  it { expect(PaymentsWorker).to be_processed_in :default }
  it { expect(PaymentsWorker).to be_retryable false }

  xit 'should trigger import_contacts on user' do
    contribution = create(:contribution)
    Sidekiq::Testing.inline! do
      expect(contribution).to receive(:complete_payment)
      PaymentsWorker.perform_async(contribution.id)
    end
  end

  it 'should function' do
    contribution = create(:contribution)
    expect { PaymentsWorker.perform_async(contribution.id) }.to change(PaymentsWorker.jobs, :size).by(1)
  end
end
