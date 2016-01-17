require 'rails_helper'

RSpec.describe 'Guest', type: :feature, js: true do
  it 'should not be able to access sidekiq page' do
    visit '/sidekiq'
    expect(page).not_to have_content('Dashboard')
  end
end
