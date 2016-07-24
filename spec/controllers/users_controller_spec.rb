require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in user, scope: :user
  end

  describe 'GET show' do
    before :each do
      process :show, method: :get, params: { id: user.id }
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'should decorate @user' do
      expect(assigns(:user)).to be_decorated
    end
  end
end
