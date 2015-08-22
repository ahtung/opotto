require 'rails_helper'

RSpec.describe 'Guest', type: :feature, js: true do

  it 'should be able to browse about page' do
    visit page_path('about')
    expect(page).to have_content t("site.about.content")
  end

  it 'should be able to browse contact page' do
    visit page_path('contact')
    expect(page).to have_content t("site.contact.content")
  end

  it 'should be able to browse contact page' do
    visit page_path('security')
    expect(page).to have_content t("site.security.content")
  end
end
