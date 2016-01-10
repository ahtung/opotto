require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do
  let(:user) { create(:user, :with_contributions) }
  let(:jar) { user.contributions.first.jar }

  before :each do
    sign_in :user, user
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new, jar_id: jar.id
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    it 'redirects to PayPal' do
      post :create, jar_id: jar.id, contribution: attributes_for(:contribution).merge(jar_id: jar.id)
      expect(response).to redirect_to('https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=')
    end
  end
end
