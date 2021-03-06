require 'rails_helper'

RSpec.describe PotsController, type: :controller do
  let(:valid_attributes) { build(:pot).attributes }
  let(:invalid_attributes) { attributes_for(:pot, name: nil) }
  let(:user) { create(:user) }

  before :each do
    sign_in user, scope: :user
  end

  # Params
  it { should permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: []).for(:create) }
  it do
    pot = create(:pot)
    should permit(:name, :description, :visible).for(:update, params: { id: pot.id })
  end

  describe 'GET show' do
    let(:pot) { create(:pot, owner: user) }

    it 'assigns @pot' do
      process :show, method: :get, params: { id: pot.id }
      expect(assigns(:pot)).to eq(pot)
    end

    it 'renders the show template' do
      process :show, method: :get, params: { id: pot.id }
      expect(response).to render_template('show')
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:pot, description: 'New') }

      it 'updates the requested pot' do
        pot = create(:pot, valid_attributes)
        process :update, method: :put, params: { id: pot.id, pot: new_attributes }
        pot.reload
        expect(pot.description).to eq('New')
      end

      it 'assigns the requested pot as @pot' do
        pot = create(:pot, valid_attributes)
        process :update, method: :put, params: { id: pot.to_param, pot: valid_attributes }
        expect(assigns(:pot)).to eq(pot)
      end

      it 'redirects to the pot' do
        pot = create(:pot, valid_attributes)
        process :update, method: :put, params: { id: pot.to_param, pot: valid_attributes }
        expect(response).to redirect_to(pot_url(Pot.last))
      end
    end

    context 'with invalid params' do
      it 'assigns the pot as @pot' do
        pot = create(:pot, valid_attributes)
        process :update, method: :put, params: { id: pot.to_param, pot: invalid_attributes }
        expect(assigns(:pot)).to eq(pot)
      end

      it "re-renders the 'edit' template" do
        pot = create(:pot, valid_attributes)
        process :update, method: :put, params: { id: pot.to_param, pot: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Pot' do
        expect do
          process :create, method: :post, params: { pot: valid_attributes }
        end.to change(Pot, :count).by(1)
      end

      it 'assigns a newly created pot as @pot' do
        process :create, method: :post, params:  { pot: valid_attributes }
        expect(assigns(:pot)).to be_a(Pot)
        expect(assigns(:pot)).to be_persisted
      end

      it 'redirects to the created pot' do
        process :create, method: :post, params: { pot: valid_attributes }
        expect(response).to redirect_to(pot_url(Pot.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved pot as @pot' do
        process :create, method: :post, params: { pot: invalid_attributes }
        expect(assigns(:pot)).to be_a_new(Pot)
      end

      it "re-renders the 'new' template" do
        process :create, method: :post, params: { pot: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET new' do
    it 'assigns @pot' do
      process :new, method: :get
      expect(assigns(:pot)).to be_a_new(Pot)
    end

    it 'renders the new template' do
      process :new, method: :get
      expect(response).to render_template('new')
    end
  end

  describe 'GET report' do
    let(:pot) { create(:pot, owner: user) }

    it 'assigns @pot' do
      process :report, method: :get, params: { id: pot.id }
      expect(assigns(:pot)).to eq(pot)
    end

    it 'assigns @abuse' do
      process :report, method: :get, params: { id: pot.id }
      expect(assigns(:abuse)).to eq(Abuse.first)
    end

    it 'renders the show template' do
      process :report, method: :get, params: { id: pot.id }
      expect(response).to redirect_to(pot_url(Pot.last))
    end
  end

  describe 'DELETE #destroy' do
    let(:pot) { create(:pot, owner: user) }

    it 'deletes a Pot' do
      process :destroy, method: :delete, params: { id: pot.to_param }
      expect(assigns(:pot).destroyed?).to be true
    end

    it 'redirects to the root_path' do
      process :destroy, method: :delete, params: { id: pot.to_param }
      expect(response).to redirect_to(root_path)
    end
  end
end
