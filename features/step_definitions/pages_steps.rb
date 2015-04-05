When(/^I visit "(.*?)"$/) do |arg1|
  visit page_path(arg1)
end

When(/^I visit Me Page$/) do
  user = FactoryGirl.create(:user, :with_jars, :with_contributions, :with_invitations)
  visit user_path(user)
end

Then(/^page should have translated "(.*?)" content$/) do |arg1|
  save_and_open_page
  expect(page).to have_content I18n.t(arg1)
end
