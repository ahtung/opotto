require 'rails_helper'

RSpec.describe 'routing to payments', type: :routing do
  it 'does route payments/success to payments#success' do
    expect(get: '/payments/success').to route_to(
      controller: 'payments',
      action: 'success'
    )
  end

  it 'does route payments/failure to payments#failure' do
    expect(get: '/payments/failure').to route_to(
      controller: 'payments',
      action: 'failure'
    )
  end
end
