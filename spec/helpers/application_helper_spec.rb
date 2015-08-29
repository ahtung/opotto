require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#phone_number_link' do
    it 'returns phone number link' do
      phone_number = '90 312 284 31 48'
      expect(helper.phone_number_link(phone_number)).to eq('<a href="tel://+90-312-284-31-48"><i class="material-icons">phone</i></a>')
    end
  end

  describe '#facebook_link' do
    it 'should return facebook page url for a given path' do
      page_path = 'pages/Ahtung/1640658482879986'
      expect(helper.facebook_link(page_path))
        .to eq('<a class="facebook_link" target="_blank" href="https://www.facebook.com/pages/Ahtung/1640658482879986"></a>')
    end
  end
end
