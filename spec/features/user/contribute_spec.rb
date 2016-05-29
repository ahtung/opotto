require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { create(:user, :with_paypal) }
  let(:pot) { create(:pot, guests: [user]) }
  let(:contribution) { build(:contribution) }

  before :each do
    login user
  end

  xit 'should be able to contribute to a pot' do
    visit new_pot_contribution_path(pot)
    fill_in 'contribution_amount', with: contribution.amount.to_f
    click_on t('pot.save')
    expect(page).to have_content('YHES')
  end
end
