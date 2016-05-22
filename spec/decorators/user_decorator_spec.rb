require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  describe 'highlighted_name' do
  end

  describe 'highlighted_email' do
    let(:user) { create(:user).decorate }

    context 'with icon' do
      it 'should return email with icon' do
        expect(user.highlighted_email(true)).to eq("<p><span class=\"true-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end

    context 'without icon' do
      it 'should return email without icon' do
        expect(user.highlighted_email(false)).to eq("<p><span class=\"false-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end

    context 'with color' do
      it 'should return email without icon with color' do
        expect(user.highlighted_email(false, 'yellow')).to eq("<p><i class=\"icon yellow\"></i><span class=\"false-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end

    context 'without color' do
      it 'should return email without icon with green color' do
        expect(user.highlighted_email(false)).to eq("<p><span class=\"false-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end
  end

  describe 'handle' do
    it 'returns name if user has first and last name' do
      user = create(:user).decorate
      expect(user.handle).to eq(user.highlighted_name(false, false, 'green'))
    end

    it 'returns name with seperator if user has first and last name' do
      user = create(:user).decorate
      expect(user.handle('-')).to eq(user.highlighted_name('-', false, 'green'))
    end

    it 'returns name with seperator and icon if user has first and last name' do
      user = create(:user).decorate
      expect(user.handle('-', 'mail outline')).to eq(user.highlighted_name('-', 'mail outline', 'green'))
    end

    it 'returns email if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      expect(user.handle).to eq("<p><span class=\"green-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
    end

    it 'returns email with icon if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      expect(user.handle(false, 'mail outline')).to eq("<p><i class=\"icon mail outline\"></i><span class=\"green-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
    end
  end
end
