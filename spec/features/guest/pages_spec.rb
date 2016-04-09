require 'rails_helper'

RSpec.describe 'Guest', type: :feature do
  describe 'should be able to browse' do
    %w(about contact security).each do |current_page|
      it "#{current_page} page" do
        visit page_path(current_page)
        expect(page).to have_content t("pages.#{current_page}.content")
      end
    end
  end
end
