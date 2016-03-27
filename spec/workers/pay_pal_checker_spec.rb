require 'rails_helper'

RSpec.describe PayPalChecker, type: :worker do
  it { expect(PayPalChecker).to be_processed_in :paypal_checker }
  it { expect(PayPalChecker).to be_retryable false }

  before :all do
    Sidekiq::Testing.inline!
  end

  it 'should trigger check_paypal on user and update paypal_member' do
    user = create(:user)
    PayPalChecker.perform_async(user.id)
    user.reload
    expect(user.paypal_member).not_to be_nil
  end

  it 'should trigger check_paypal on user and update paypal_country' do
    user = create(:user)
    PayPalChecker.perform_async(user.id)
    user.reload
    expect(user.paypal_country).not_to be_nil
  end

  it 'should function' do
    user = create(:user)
    Sidekiq::Testing.fake! do
      expect { PayPalChecker.perform_async(user.id) }.to change(PayPalChecker.jobs, :size).by(1)
    end
  end

  after :all do
    Sidekiq::Testing.fake!
  end
end
