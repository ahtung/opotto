require 'rails_helper'

RSpec.describe JarsController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in :user, user
  end

  describe 'GET show' do
    let(:jar) { create(:jar, owner: user) }

    it 'assigns @jar' do
      get :show, id: jar.id
      expect(assigns(:jar)).to eq(jar)
    end

    it 'renders the show template' do
      get :show, id: jar.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    it 'assigns @jar' do
      get :new
      expect(assigns(:jar)).to be_a_new(Jar)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
