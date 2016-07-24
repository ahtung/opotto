require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'user with name' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3, :with_name)
      @pot = create(:pot, :with_description)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @pot).deliver_now
      end
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to eq 3
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to match_array @user.email
    end

    it 'should set the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq "You're invited to contribute!"
    end

    it 'should have pots name in its content' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(@pot.name)
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@ahtung.co']
    end

    it 'should have user\'s name in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{@user.name}")
    end
  end

  describe 'user without name' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3)
      @pot = create(:pot, :with_description)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @pot).deliver_now
      end
    end

    it 'should have user\'s email in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{@user.email}")
    end
  end

  describe 'a registered user' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3, :registered)
      @pot = create(:pot, :with_description)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @pot).deliver_now
      end
    end

    it 'should not have an introductin message for opotto in the body' do
      expect(ActionMailer::Base.deliveries.first.body).not_to have_css('div#introduction_to_opotto')
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end

  describe 'a non registered user' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      users = create_list(:user, 3, last_sign_in_at: nil)
      @pot = create(:pot, :with_description)
      @user = users.first
      users.each do |user|
        UserMailer.invitation_email(user, @pot).deliver_now
      end
    end

    it 'should not have an introductin message for opotto in the body' do
      expect(ActionMailer::Base.deliveries.last.body).to have_css('div#introduction_to_opotto')
    end
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
