require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin, email: 'onurkucukkece@gmail.com', password: '123QwETR') }

  it 'should not be able to access sidekiq page' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Sign in'
    visit '/sidekiq'
    expect(page).not_to have_content('Dashboard')
  end
end
