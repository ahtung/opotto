require 'rails_helper'

RSpec.describe PaymentsWorker, type: :worker do
  let!(:worker) { PaymentsWorker.new }

  it { expect(PaymentsWorker).to be_processed_in :payments }
  it { expect(PaymentsWorker).to be_retryable false }

  before :all do
    Sidekiq::Testing.inline!
  end

  it 'should not trigger complete_payment on an initiated contribution' do
    contribution = create(:contribution)
    worker.perform([contribution.id])
    expect(contribution).not_to receive(:complete_payment)
  end

  it 'should not trigger complete_payment on an completed contribution' do
    contribution = create(:contribution, :completed)
    worker.perform([contribution.id])
    expect(contribution).not_to receive(:complete_payment)
  end

  it 'should trigger complete_payment on a scheduled contribution to update payment_key' do
    contribution = create(:contribution, :scheduled)
    PaymentsWorker.perform_async([contribution.id])
    contribution.reload
    expect(contribution.payment_key).not_to be_nil
  end

  it 'should trigger complete_payment on a scheduled contribution to update state' do
    contribution = create(:contribution, :scheduled)
    PaymentsWorker.perform_async([contribution.id])
    contribution.reload
    expect(contribution.state).to eq('completed')
  end

  it 'should function' do
    contribution = create(:contribution)
    Sidekiq::Testing.fake! do
      expect { PaymentsWorker.perform_async([contribution.id]) }.to change(PaymentsWorker.jobs, :size).by(1)
    end
  end

  after :all do
    Sidekiq::Testing.fake!
  end
end
