When(/^create a jar$/) do
  dummy_jar = build(:jar)
  click_on t('jar.new')

  fill_in 'jar_name', with: dummy_jar.name
  # fill_in 'jar_name', dummy_jar.name
  # fill_in 'jar_name', dummy_jar.name
  fill_in 'jar_description', with: dummy_jar.description
  fill_in 'jar_upper_bound', with: dummy_jar.upper_bound
  # fill_in 'jar_name', dummy_jar.name
  # fill_in 'jar_name', dummy_jar.name
  # fill_in 'jar_name', dummy_jar.name

  click_on t('jar.save')
end

Then(/^I should see user's contributed jars$/) do
  user = User.last
  within '.contributions' do
    expect(page).to have_selector '.jar', count: user.contributed_jars.count
  end
end

Then(/^I should see user's created jars$/) do
  user = User.last
  within '.creations' do
    expect(page).to have_selector '.jar', count: user.jars.count
  end
end

Then(/^I should see user's invited jars$/) do
  user = User.last
  within '.invitations' do
    expect(page).to have_selector '.jar', count: user.invited_jars.count
  end
end
