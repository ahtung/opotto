require 'rails_helper'

RSpec.describe 'routing to jars', type: :routing do
  it 'does route jars/:id tp payments#show' do
    expect(get: '/jars/1').to route_to(
      controller: 'jars',
      action: 'show',
      id: '1'
    )
  end

  it 'does route jars/new tp payments#new' do
    expect(get: '/jars/new').to route_to(
      controller: 'jars',
      action: 'new'
    )
  end
end
