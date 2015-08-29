require 'rails_helper'

RSpec.describe JarsController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in :user, user
  end

  # Params
  it { should permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: []).for(:create) }
  xit { should permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: []).for(:update) }

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
