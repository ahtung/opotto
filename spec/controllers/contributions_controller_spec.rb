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
end
