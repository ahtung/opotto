Given(/^I have accept language (.*)$/) do |locale|
  page.driver.add_headers(:'Accept-Language' => locale)
  I18n.locale = locale
end

When(/^I visit root$/) do
  visit(root_path)
end

Then(/^page should have "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end