require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user, :with_paypal) }
  let!(:onur) { create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR') }

  let(:pot) { build(:pot) }

  before :each do
    user.friends << onur
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  xit 'should be able to create a pot' do
    click_on 'Get going'
    fill_in 'pot_name', with: pot.name

    first('.receiver-select .select-dropdown').click
    first('.receiver-select .select-dropdown').first('li').click

    first('.guests-select .select-dropdown').click
    first('.guests-select .select-dropdown').first('li').click

    fill_in 'pot_description', with: pot.description
    fill_in 'pot_end_at', with: Time.zone.now + 10.days
    check 'pot_visible'
    fill_in 'pot_upper_bound', with: pot.upper_bound
    click_on t('pot.save')
    within '.creations' do
      expect(page).to have_selector '.pot', count: user.pots.count
    end
  end
end
