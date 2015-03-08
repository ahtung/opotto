require 'rails_helper'

describe 'As a Guest' do
  before :each do
    visit root_path
  end

  describe 'I should be able to click on New' do
    before :each do
      click_on t('jar.new')
    end

    it 'and see the an error' do
      expect(page).to have_content t('devise.failure.user.unauthenticated')
    end
  end
end
