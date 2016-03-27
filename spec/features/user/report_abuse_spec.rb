require 'rails_helper'

RSpec.describe 'Guest', type: :feature do
  let!(:user) { create(:user) }
  let!(:pot) { create(:jar, :public) }

  it 'should be able to report abuse for a pot' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    visit jar_path(pot)
    click_on 'Report abuse'
    expect(page).to have_content(t('jar.reported'))
  end
end
