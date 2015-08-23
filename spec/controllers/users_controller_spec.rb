require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in :user, user
  end

  describe 'GET show' do
    it 'assigns @user' do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      get :show, id: user.id
      expect(response).to render_template('show')
    end
  end
end
