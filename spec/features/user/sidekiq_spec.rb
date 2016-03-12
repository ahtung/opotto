require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user, :with_paypal) }
  let!(:admin) { create(:user, :admin, email: 'onurkucukkece@gmail.com', password: '123QwETR') }

  it 'should not be able to access sidekiq page' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Sign in'
    visit '/sidekiq'
    expect(page).not_to have_content('Dashboard')
  end

  it 'should be able to access sidekiq page if admin' do
    visit new_user_session_path
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_on 'Sign in'
    visit sidekiq_web_path
    expect(page).to have_content('Dashboard')
  end
end
