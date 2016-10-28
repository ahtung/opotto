require 'rails_helper'

RSpec.describe 'Guest', type: :feature, js: true do
  it 'should be able to change language to Turkish' do
    visit page_path('about')
    within '.footer' do
      find('.floating').click
      click_on 'Türkçe'
    end
    expect(page).to have_content 'Hakkında'
  end

  it 'should be able to change language to English' do
    visit page_path('security')
    within '.footer' do
      find('.floating').click
      click_on 'Global'
    end
    expect(page).to have_content 'Privacy'
  end
end
