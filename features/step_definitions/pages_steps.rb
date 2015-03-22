When(/^I visit about page$/) do
  visit('/pages/about')
end

Then(/^page should have translated "(.*?)" content$/) do |arg1|
  expect(page).to have_content I18n.t(arg1)
end