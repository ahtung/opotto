require 'rails_helper'

RSpec.describe UserMailer, type: :mailer, focus: true do

  describe 'user with name' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3, :with_name)
      @jar = create(:jar, :with_message)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @jar).deliver_now
      end
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 3
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to match_array @user.email
    end

    it 'should set the subject to the correct subject' do
      ActionMailer::Base.deliveries.first.subject.should == "You're invited to contribute!"
    end

    it 'should have a message in its content' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(@jar.message)
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@opotto.com']
    end

    it 'should have user\'s name in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{@user.name}")
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end

  describe 'user without name' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3)
      @jar = create(:jar, :with_message)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @jar).deliver_now
      end
    end

    it 'should have user\'s email in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{@user.email}")
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end


end
