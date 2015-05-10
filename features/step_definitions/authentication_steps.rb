Given(/^I am not authenticated$/) do
  visit('/users/sign_out')
end

When(/^I sign in as a user with Google$/) do
  request.env['devise.mapping'] = Devise.mappings[:user] # If using Devise
  request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  create(:user, :with_contributions, email: 'test@xxx.com')
  visit '/users/auth/google_oauth2'
end

When(/^I sign in with "(.*?)"$/) do |email|
  dunya = create(:user, :with_invitations, :with_contributions, :with_jars, email: email)
  onur = create(:user, :onur, email: 'onurkucukkece@gmail.com', password: '123QwETR')
  us = create(:user, :with_paypal, password: '123QwETR')
  onur.friends << [dunya, us]
  dunya.friends << [onur, us]

  user = User.where(email: email).first
  login_as(user, scope: :user)
  visit authenticated_root_path
end
