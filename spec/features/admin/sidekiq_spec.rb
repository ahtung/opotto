require 'rails_helper'

RSpec.describe 'Admin', type: :feature do
  let!(:user) { create(:user, :with_paypal) }
  let!(:admin) { create(:user, :admin, email: 'onurkucukkece@gmail.com', password: '123QwETR') }

  it 'should be able to access sidekiq page if admin' do
    visit new_user_session_path
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_on 'Sign in'
    visit sidekiq_web_path
    expect(page).to have_content('Dashboard')
  end
end
