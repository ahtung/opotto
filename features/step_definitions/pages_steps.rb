When(/^I visit "(.*?)"$/) do |arg1|
  visit eval(arg1)
end

When(/^I visit Me Page$/) do
  user = FactoryGirl.create(:user, :with_jars, :with_contributions, :with_invitations)
  visit user_path(user)
end

Then(/^page should have translated "(.*?)" content$/) do |arg1|
  expect(page).to have_content I18n.t(arg1)
end
