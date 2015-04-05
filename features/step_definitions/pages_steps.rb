When(/^I visit Security Page$/) do
  visit('/pages/security')
end

When(/^I visit about page$/) do
  visit('/pages/about')
end

Then(/^page should have translated "(.*?)" content$/) do |arg1|
  expect(page).to have_content I18n.t(arg1)
end

When(/^I visit Contact Page$/) do
  visit '/pages/contact'
end

When(/^I visit Me Page$/) do
  user = FactoryGirl.create(:user, :with_jars, :with_contributions, :with_invitations)
  visit user_path(user)
end
