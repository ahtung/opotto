require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let(:user) { create(:user, :with_paypal, password: '123QwETR') }
  let(:jar) { build(:jar) }

  before :each do
    login_as(user, scope: :user)
    visit authenticated_root_path
  end

  xit 'should be able to create a jar' do
    click_on t('jar.new')
    fill_in 'jar_name', with: jar.name
    select2 'onurkucukkece@gmail.com', from: t('jar.receiver')
    select2 'us-personal@gmail.com', multi: true, from: t('activerecord.attributes.jar.guest_ids')
    fill_in 'jar_description', with: jar.description
    fill_in 'jar_end_at_date', with: Time.zone.now + 10.days
    fill_in 'jar_end_at_time', with: Time.zone.now + 10.days
    check 'jar_visible'
    fill_in 'jar_upper_bound', with: jar.upper_bound
    click_on t('jar.save')
    within '.creations' do
      expect(page).to have_selector '.jar', count: user.jars.count
    end
  end

  xit 'should be able to create a jar' do
    visit user_path(user)
    expect(page).to eq('error')
  end
end
