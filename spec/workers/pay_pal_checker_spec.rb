require 'rails_helper'

RSpec.describe PayPalChecker, type: :worker do
  it { expect(PayPalChecker).to be_processed_in :paypal_checker }
  it { expect(PayPalChecker).to be_retryable false }

  xit 'should trigger check_paypal on user' do
    user = create(:user)
    Sidekiq::Testing.inline! do
      expect(user).to receive(:check_paypal)
      PayPalChecker.perform_async(user.id)
    end
  end

  it 'should function' do
    user = create(:user)
    expect { PayPalChecker.perform_async(user.id) }.to change(PayPalChecker.jobs, :size).by(1)
  end
end
