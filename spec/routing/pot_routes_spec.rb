require 'rails_helper'

RSpec.describe 'routing to pots', type: :routing do
  it 'does route pots/:id to payments#show' do
    expect(get: '/pots/1').to route_to(
      controller: 'pots',
      action: 'show',
      id: '1'
    )
  end

  it 'does route pots/new to payments#new' do
    expect(get: '/pots/new').to route_to(
      controller: 'pots',
      action: 'new'
    )
  end
end
