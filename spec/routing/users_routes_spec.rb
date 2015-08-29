require 'rails_helper'

RSpec.describe 'routing to users', type: :routing do
  it 'does route /users/ to users#show' do
    expect(get: '/users/1').to route_to(
      controller: 'users',
      action: 'show',
      id: '1'
    )
  end
end
