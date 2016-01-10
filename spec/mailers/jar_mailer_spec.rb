require 'rails_helper'

RSpec.describe JarMailer, type: :mailer do
  let(:contribution) { create(:contribution) }

  describe 'scheduled_email' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      JarMailer.scheduled_email(contribution).deliver_now
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to match_array contribution.user.email
    end

    it 'should set the subject to the correct subject' do
      ActionMailer::Base.deliveries.first.subject.should == 'Your contribution sucessfully scheduled!'
    end

    it 'should have a message in its content' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(contribution.jar.description)
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@ahtung.co']
    end

    it 'should have user\'s name in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{contribution.user.name}")
    end

    it 'should have link to jar' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_link(contribution.jar.name, href: jar_url(contribution.jar))
    end

    it 'should have a header' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_css('h1')
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end

  describe 'completed_email' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      JarMailer.completed_email(contribution).deliver_now
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to match_array contribution.user.email
    end

    it 'should set the subject to the correct subject' do
      ActionMailer::Base.deliveries.first.subject.should == 'You have sucessfully contributed!'
    end

    it 'should have a message in its content' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(contribution.jar.description)
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@ahtung.co']
    end

    it 'should have user\'s name in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{contribution.user.name}")
    end

    it 'should have a header' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_css('h1')
    end

    it 'should have link to jar' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_link(contribution.jar.name, href: jar_url(contribution.jar))
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end

  describe 'failed_payment_email' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      JarMailer.failed_payment_email(contribution).deliver_now
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to match_array contribution.user.email
    end

    it 'should have link to jar' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_link(contribution.jar.name, href: jar_url(contribution.jar))
    end

    it 'should set the subject to the correct subject' do
      ActionMailer::Base.deliveries.first.subject.should == 'Your payment has failed'
    end

    it 'should have a message in its content' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content(contribution.jar.description)
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to match_array ['info@ahtung.co']
    end

    it 'should have user\'s name in the body' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_content("Hello #{contribution.user.name}")
    end

    it 'should have a header' do
      expect(ActionMailer::Base.deliveries.first.body.encoded).to have_css('h1')
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end
end