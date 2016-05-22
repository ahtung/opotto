require 'spec_helper'

RSpec.describe UserDecorator, type: :decorator do
  describe 'handle' do
    it 'returns name if user has first and last name' do
      user = create(:user, first_name: 'Dunya', last_name: 'Kirkali').decorate
      expect(user.handle).to eq(user.highlighted_name)
    end

    it 'returns name with seperator if user has first and last name' do
      user = create(:user, first_name: 'Dunya', last_name: 'Kirkali').decorate
      expect(user.handle('-')).to eq(user.highlighted_name('-'))
    end

    it 'returns name with seperator and icon if user has first and last name' do
      user = create(:user, first_name: 'Dunya', last_name: 'Kirkali').decorate
      expect(user.handle('-', 'mail outline')).to eq(user.highlighted_name('-', 'mail outline'))
    end

    it 'returns email if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      expect(user.handle).to eq(user.highlighted_email)
    end

    it 'returns email with icon if user has no name' do
      user = create(:user, first_name: nil, last_name: nil).decorate
      expect(user.handle(false, 'mail outline')).to eq(user.highlighted_email('mail outline'))
    end
  end
end
