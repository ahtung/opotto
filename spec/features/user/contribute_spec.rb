require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let(:user) { create(:user, :with_paypal, password: '123QwETR') }
  let(:pot) { create(:pot, guests: [user]) }
  let(:contribution) { build(:contribution) }

  xit 'should be able to contribute to a pot' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'

    visit new_pot_contribution_path(pot)

    fill_in 'contribution_amount', with: contribution.amount.to_f
    click_on t('pot.save')

    expect(page).to eq('YHES')
  end
end
