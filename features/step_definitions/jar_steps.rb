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
