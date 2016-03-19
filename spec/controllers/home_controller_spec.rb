require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    describe 'from the NL' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'from JP' do
      xit 'renders the index template' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return('58.3.128.0')
        get :index
        expect(response).to redirect_to(page_path('unsupported'))
      end
    end
  end
end
