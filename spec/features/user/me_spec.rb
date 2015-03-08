require 'rails_helper'

describe 'User should be able to' do
  let!(:user) { create(:user, :with_jars, :with_contributions, :with_invitations) }

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
    within '.contributions' do
      expect(page).to have_selector '.jar', count: user.contributed_jars.count
    end
  end

  it "see 'created' section" do
    expect(page).to have_content 'Created'
  end

  it 'see jars that he/she has created' do
    within '.creations' do
      expect(page).to have_selector '.jar', count: user.jars.count
    end
  end

  it "see 'invited' section" do
    expect(page).to have_content 'Invited'
  end

  it 'see jars that he/she has been invited to' do
    within '.invitations' do
      expect(page).to have_selector '.jar', count: user.invited_jars.count
    end
  end
end
