# WHEN
When(/^create a jar$/) do
  dummy_jar = build(:jar)
  click_on t('jar.new')
  fill_in_jar_form(dummy_jar)
  click_on t('jar.save')
end

When(/^read a jar$/) do
  user = User.where(email: 'dunyakirkali@gmail.com').first
  visit user_path(user)
end

When(/^update a jar$/) do
  user = User.where(email: 'dunyakirkali@gmail.com').first
  dummy_jar = build(:jar)
  visit user_path(user)
  click_on user.jars.first.name
  click_on t('jar.edit')
  fill_in_jar_form(dummy_jar)
  click_on t('jar.save')
end

# THEN
Then(/^I should see user's contributed jars$/) do
  user = User.where(email: 'dunyakirkali@gmail.com').first
  within '.contributions' do
    expect(page).to have_selector '.jar', count: user.contributed_jars.count
  end
end

Then(/^I should see user's created jars$/) do
  user = User.where(email: 'dunyakirkali@gmail.com').first
  within '.creations' do
    expect(page).to have_selector '.jar', count: user.jars.count
  end
end

Then(/^I should see user's invited jars$/) do
  user = User.where(email: 'dunyakirkali@gmail.com').first
  within '.invitations' do
    expect(page).to have_selector '.jar', count: user.invited_jars.count
  end
end
