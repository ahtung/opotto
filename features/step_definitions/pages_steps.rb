When(/^I visit Contact Page$/) do
  visit '/pages/contact'
end

When(/^I visit Me Page$/) do
  user = FactoryGirl.create(:user, :with_jars, :with_contributions, :with_invitations)
  visit user_path(user)
end
