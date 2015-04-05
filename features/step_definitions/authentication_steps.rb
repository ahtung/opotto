Given(/^I am not authenticated$/) do
  visit('/users/sign_out')
end

When(/^I sign in as a user with Google$/) do
  request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  FactoryGirl.create(:user, :with_contributions, email: 'test@xxx.com')
  visit '/users/auth/google_oauth2'
end
