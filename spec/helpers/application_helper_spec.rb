require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#phone_number_link' do
    it 'returns phone number link' do
      phone_number = '90 312 284 31 48'
      expect(helper.phone_number_link(phone_number))
        .to eq('<a href="tel://+90-312-284-31-48"><i class="material-icons">phone</i></a>')
    end
  end

  describe '#facebook_link' do
    it 'should return facebook page url for a given path' do
      page_path = 'pages/Ahtung/1640658482879986'
      expect(helper.facebook_link(page_path))
        .to eq('<a class="facebook_link" target="_blank" href="https://www.facebook.com/pages/Ahtung/1640658482879986"></a>')
    end
  end

  describe '#share_on' do
    it 'should return facebook sharer link if the service is set to facebook' do
      expect(helper.share_on('facebook', 'title', 'http://www.facebook.com'))
        .to eq('http://www.facebook.com/share.php?u=http://www.facebook.com&title=title')
    end

    it 'should return twitter sharer link if the service is set to twitter' do
      expect(helper.share_on('twitter', 'title', 'http://www.twitter.com'))
        .to eq('http://twitter.com/home?status=title+http://www.twitter.com')
    end

    it 'should return google sharer link if the service is set to google' do
      expect(helper.share_on('google', nil, 'http://www.google.com'))
        .to eq('https://plus.google.com/share?url=www.google.com')
    end
  end

  describe '#social_window' do
    it 'should return onClick attribute value for social links' do
      expect(helper.social_window)
        .to eq("window.open(this.href, 'social', 'height=500,left=20,toolbar=1,top=20,width=500');return false;")
    end
  end

  describe '#mobile?' do
    it 'should return nil if no headers' do
      expect(helper.mobile?).to eq(nil)
    end
  end

  describe '#opotto_icons' do
    it 'should return opotto icon color set' do
      icons = {
        home: 'red',
        student: 'orange',
        gift: 'yellow',
        plane: 'olive',
        diamond: 'green',
        truck: 'teal',
        trophy: 'blue',
        empty_heart: 'violet'
      }
      expect(helper.opotto_icons).to eq(icons)
    end
  end
end
