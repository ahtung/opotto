require 'rails_helper'

describe 'User' do
  let(:user) { create(:user) }

  before :each do
    login_as user
    visit authenticated_root_path
    click_on 'Stats'
  end

  it 'see his/her stats page' do
    expect(page).to have_content 'Stats'
  end

  describe 'with contributions' do
    let(:user) { create(:user, :with_contributions) }

    it "see 'contributed to' section" do
      expect(page).to have_content 'Contributed To'
    end

    it 'see jars that he/she has contributed to' do
      within '.contributions' do
        expect(page).to have_selector '.jar', count: user.contributed_jars.count
      end
    end
  end


  describe 'with jars' do
    let(:user) { create(:user, :with_jars) }

    it "should be able to see 'created' section" do
      expect(page).to have_content 'Created'
    end

    it 'should be able to see jars that he/she has created' do
      within '.creations' do
        expect(page).to have_selector '.jar', count: user.jars.count
      end
    end
  end

  describe 'invited to jars' do
    let(:user) { create(:user, :with_invitations) }

    it "should be able to see 'invited' section" do
      expect(page).to have_content 'Invited'
    end

    it 'should be able to see jars that he/she has been invited to' do
      within '.invitations' do
        expect(page).to have_selector '.jar', count: user.invited_jars.count
      end
    end
  end
end
