# Application Helper
module ApplicationHelper
  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+#{sets_of_numbers.join('-')}"
    link_to "tel://#{number}" do
      '<i class="material-icons">phone</i>'.html_safe
    end
  end

  def facebook_link(page_path)
    link_to '', "https://www.facebook.com/#{page_path}", class: 'facebook_link', target: '_blank'
  end

  def share_on(service, title, url)
    return "http://www.facebook.com/share.php?u=#{url}&title=#{title}" if service == 'facebook'
    return "http://twitter.com/home?status=#{title}+#{url}" if service == 'twitter'
    return "https://plus.google.com/share?url=#{url.gsub(%r{\w+:\/\/}, '')}" if service == 'google'
  end

  def social_window
    uri = Addressable::URI.new
    uri.query_values = { left: 20, top: 20, width: 500, height: 500, toolbar: 1 }
    "window.open(this.href, 'social', '#{uri.query.tr('&', ',')}');return false;"
  end

  def mobile?
    browser.device.mobile?
  end
end
