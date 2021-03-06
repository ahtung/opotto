require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  let!(:user) { create(:user, :admin) }
  let!(:pot) { create(:pot, :with_description) }

  before(:each) do
    ActionMailer::Base.deliveries = []
    AdminMailer.update_email.deliver_now
  end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq 1
  end

  it 'renders the receiver email' do
    ActionMailer::Base.deliveries.first.to match_array user.email
  end

  it 'should set the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq "This week's pots"
  end

  it 'should have a message in its content' do
    expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(pot.description)
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@ahtung.co']
  end

  it 'should have user\'s name in the body' do
    expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{user.name}")
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
