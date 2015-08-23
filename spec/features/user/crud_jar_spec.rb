require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user, :with_paypal) }
  let!(:onur) { create(:user, email: 'onurkucukkece@gmail.com', password: '123QwETR') }

  let(:jar) { build(:jar) }

  before :each do
    user.friends << onur
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  fit 'should be able to create a jar' do
    click_on 'Get going'
    fill_in 'jar_name', with: jar.name

    first(".receiver-select .select-dropdown").click
    first(".receiver-select .select-dropdown").first('li').click

    first(".guests-select .select-dropdown").click
    first(".guests-select .select-dropdown").first('li').click

    fill_in 'jar_description', with: jar.description
    fill_in 'jar_end_at', with: Time.zone.now + 10.days
    check 'jar_visible'
    fill_in 'jar_upper_bound', with: jar.upper_bound
    click_on t('jar.save')
    within '.creations' do
      expect(page).to have_selector '.jar', count: user.jars.count
    end
  end
end
