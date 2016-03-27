require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do
  let(:user) { create(:user, :with_contributions) }
  let(:pot) { user.contributions.first.pot }

  before :each do
    sign_in :user, user
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new, pot_id: pot.id
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    it 'redirects to PayPal' do
      post :create, pot_id: pot.id, contribution: attributes_for(:contribution).merge(pot_id: pot.id)
      expect(response).to redirect_to('https://www.sandbox.paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=')
    end
  end
end
