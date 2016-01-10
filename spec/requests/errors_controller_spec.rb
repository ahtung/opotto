require 'rails_helper'

RSpec.describe ErrorsController, type: :request do
  describe 'GET show' do
    it 'uses application layout' do
      get '404'
      expect(response).to render_template(layout: :application)
    end

    it 'skips authenticate_user!' do
      get '404'
      controller.should_not_receive(:authenticate_user!)
    end
  end
end
