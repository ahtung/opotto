require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before(:each) do
    ActionMailer::Base.deliveries = []
    users = create_list(:user, 3)
    @user = users.first
    users.each do |user|
      UserMailer.invitation_email(user).deliver_now
    end
  end

  it 'should send an email' do
    ActionMailer::Base.deliveries.count.should == 3
  end

  it 'renders the receiver email' do
    ActionMailer::Base.deliveries.first.to match_array @user.email
  end

  it 'should set the subject to the correct subject' do
    ActionMailer::Base.deliveries.first.subject.should == "You're invited to contribute'!"
  end

  it 'renders the sender email' do
    ActionMailer::Base.deliveries.first.from.should == ['invitations@potto.com']
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
