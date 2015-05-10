# WHEN
When(/^create a jar$/) do
  dummy_jar = build(:jar)
  click_on t('jar.new')
  fill_in 'jar_name', with: dummy_jar.name
  select2 'onurkucukkece@gmail.com', from: t('jar.receiver')
  select2 'us-personal@gmail.com', {multi: true, from: t('activerecord.attributes.jar.guest_ids')}
  fill_in 'jar_description', with: dummy_jar.description
  fill_in 'jar_end_at_date', with: DateTime.now + 10.days
  fill_in 'jar_end_at_time', with: DateTime.now + 10.days
  check 'jar_visible'
  fill_in 'jar_upper_bound', with: dummy_jar.upper_bound
  click_on t('jar.save')
end

When(/^read a jar$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^update a jar$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^destroy a jar$/) do
  pending # express the regexp above with the code you wish you had
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

