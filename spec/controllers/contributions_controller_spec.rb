require 'rails_helper'

RSpec.describe ContributionsController, type: :controller do
  let(:user) { create(:user, :with_contributions) }
  let(:valid_attributes) { build(:contribution).attributes }
  let(:invalid_attributes) { attributes_for(:contribution, amount: nil) }
  let(:pot) { user.contributions.first.pot }

  before :each do
    sign_in user, scope: :user
  end

  describe 'GET new' do
    it 'renders the new template' do
      process :new, method: :get, params: { pot_id: pot.id }
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Contribution' do
        expect do
          process :create, method: :post, params: { pot_id: pot.id, contribution: attributes_for(:contribution).merge(pot_id: pot.id) }
        end.to change(Contribution, :count).by(1)
      end

      it 'assigns a newly created contribution as @contribution' do
        process :create, method: :post, params: { pot_id: pot.id, contribution: attributes_for(:contribution).merge(pot_id: pot.id) }
        expect(assigns(:contribution)).to be_a(Contribution)
        expect(assigns(:contribution)).to be_persisted
      end

      it 'redirects to PaymentPortal'
    end

    context 'with invalid params' do
      before :each do
        process :create, method: :post, params: { pot_id: pot.id, contribution: attributes_for(:contribution, amount: nil).merge(pot_id: pot.id) }
      end

      it 'assigns a newly created but unsaved contribution as @contribution' do
        expect(assigns(:contribution)).to be_a_new(Contribution)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template('new')
      end
    end
  end
end
