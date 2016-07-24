require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user) { create(:user, :with_contributions) }
  let(:contribution) { user.contributions.first }

  before :each do
    sign_in user, scope: :user
  end

  describe 'GET success' do
    it 'renders the success template' do
      get :success, contribution: contribution.id
      expect(response).to render_template('success')
    end
  end

  describe 'GET failure' do
    it 'renders the failure template' do
      get :failure, contribution: contribution.id
      expect(response).to render_template('failure')
    end
  end
end
