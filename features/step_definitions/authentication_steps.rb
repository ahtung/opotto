Given(/^I am not authenticated$/) do
  visit('/users/sign_out')
end

When(/^I sign in as a user with Google$/) do
  visit '/users/auth/google_oauth2'
end
