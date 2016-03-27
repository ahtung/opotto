require 'rails_helper'

RSpec.describe PotsController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in :user, user
  end

  # Params
  it { should permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: []).for(:create) }
  xit { should permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: []).for(:update) }

  describe 'GET show' do
    let(:pot) { create(:pot, owner: user) }

    it 'assigns @pot' do
      get :show, id: pot.id
      expect(assigns(:pot)).to eq(pot)
    end

    it 'renders the show template' do
      get :show, id: pot.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    it 'assigns @pot' do
      get :new
      expect(assigns(:pot)).to be_a_new(Pot)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
