require 'rails_helper'

RSpec.describe 'Guest', type: :feature, js: true do
  it 'should be able to browse about page' do
    visit page_path('about')
    expect(page).to have_content t('pages.about.content')
  end

  it 'should be able to browse contact page' do
    visit page_path('contact')
    expect(page).to have_content t('pages.contact.content')
  end

  it 'should be able to browse contact page' do
    visit page_path('security')
    expect(page).to have_content t('pages.security.content')
  end
end
