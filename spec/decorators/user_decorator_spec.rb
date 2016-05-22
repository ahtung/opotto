require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do
  before :each do
    @options = {
      seperator: ' ',
      icon: false,
      color: 'green'
    }
  end

  describe 'highlighted_name' do
  end

  describe 'highlighted_email' do
    let(:user) { create(:user).decorate }

    context 'with icon' do
      it 'should return email with icon' do
        @options[:icon] = 'mail outline'
        expect(user.highlighted_email(@options)).to eq("<p><i class=\"icon mail outline\"></i><span class=\"green-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end

    context 'without icon' do
      it 'should return email without icon' do
        expect(user.highlighted_email(@options)).to eq("<p><span class=\"green-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>")
      end
    end
  end

  describe 'handle' do
    it 'returns name if user has first and last name' do
      user = create(:user).decorate
      expect(user.handle).to eq(user.highlighted_name(@options))
    end

    it 'returns name with seperator if user has first and last name' do
      user = create(:user).decorate
      @options[:seperator] = '-'
      expect(user.handle('-')).to eq(user.highlighted_name(@options))
    end

    it 'returns name with seperator and icon if user has first and last name' do
      user = create(:user).decorate
      @options[:seperator] = '-'
      @options[:icon] = 'mail outline'
      expect(user.handle('-', 'mail outline')).to eq(user.highlighted_name(@options))
    end

    it 'returns email if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      expect(user.handle).to eq(user.highlighted_email(@options))
    end

    it 'returns email with icon if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      @options[:icon] = 'mail outline'
      expect(user.handle(false, 'mail outline')).to eq(user.highlighted_email(@options))
    end
  end
end
