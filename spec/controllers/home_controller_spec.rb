require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    describe 'from the NL' do
      it 'renders the index template' do
        @request.env['HTTP_CF_IPCOUNTRY'] = 'NL'
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'from JP' do
      it 'renders the index template' do
        @request.env['HTTP_CF_IPCOUNTRY'] = 'JP'
        get :index
        expect(response).to redirect_to(page_path('unsupported'))
      end
    end
  end
end
