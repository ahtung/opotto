require 'rails_helper'

RSpec.describe 'I18n', type: :feature do

  before do
    page.driver.header 'Accept-Language', locale
    I18n.locale = locale
  end

  context 'when the user has set their locale to :en' do
    let(:locale) { :en }

    it 'displays a translated welcome message to the user' do
      visit(root_path)
      expect(page).to have_content t('site.title')
    end
  end

  context 'when the user has set their locale to :zh' do
    let(:locale) { :tr }

    it 'displays a translated welcome message to the user' do
      visit(root_path)
      expect(page).to have_content t('site.title')
    end
  end
end