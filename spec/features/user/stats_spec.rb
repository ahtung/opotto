require 'rails_helper'

describe 'User should be able to', focus: true do
  let!(:user) { create(:user, :with_jars) }

  before :each do
    login_as user
    visit authenticated_root_path
    click_on 'Stats'
  end

  it 'see his/her stats page' do
    expect(page).to have_content 'Stats'
  end

  it "see 'contributed to' section" do
    expect(page).to have_content 'Contributed To'
  end

  it 'see jars that he/she has contributed to' do
    expect(page).to have_selector '.jar', count: user.jars.count
  end

  it "see 'created' section" do
    expect(page).to have_content 'Created'
  end

  it 'see jars that he/she has created' do
    expect(page).to have_selector '.jar', count: user.jars.count
  end
end
