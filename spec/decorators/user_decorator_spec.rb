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
    let(:user) { create(:user).decorate }

    it 'should return user name without an icon' do
      expect(user.highlighted_name(@options)).to eq("<p><span class=\"green-text\">#{user.first_name.upcase}</span> <span class=\"grey-text\">#{user.last_name}</span></p>")
    end

    it 'should return user name with an icon' do
      @options[:icon] = 'mail outline'
      expect(user.highlighted_name(@options)).to eq("<p><i class=\"icon mail outline\"></i><span class=\"green-text\">#{user.first_name.upcase}</span> <span class=\"grey-text\">#{user.last_name}</span></p>")
    end
  end

  describe 'put_icon' do
    let(:user) { create(:user).decorate }

    it 'should return an icon if it is set' do
      expect(user.put_icon('mail outline')).to eq('<i class="icon mail outline"></i>')
    end

    it 'should return nothing unless icon is set' do
      expect(user.put_icon(false)).to eq(nil)
    end
  end

  describe 'decorated_name' do
    let(:user) { create(:user).decorate }

    it 'should only return decorated name & surname' do
      expect(user.decorated_name(' ', 'green')).to eq("<span class=\"green-text\">#{user.first_name.upcase}</span> <span class=\"grey-text\">#{user.last_name}</span>")
    end
  end

  describe 'highlighted_email' do
    let(:user) { create(:user).decorate }

    context 'with icon' do
      it 'should return email with icon' do
        @options[:icon] = 'mail outline'
        output = "<p><i class=\"icon mail outline\"></i><span class=\"green-text\">#{user.email.match(/^(.*)@.*$/)[1]}</span></p>"
        expect(user.highlighted_email(@options)).to eq(output)
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
      expect(user.handle(' ', 'mail outline')).to eq(user.highlighted_email(@options))
    end
  end
end
