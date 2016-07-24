# Application Helper
module ApplicationHelper
  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+#{sets_of_numbers.join('-')}"
    link_to "tel://#{number}" do
      content_tag :i, phone, class: 'material-icons'
    end
  end

  def facebook_link(page_path)
    link_to '', "https://www.facebook.com/#{page_path}", class: 'facebook_link', target: '_blank'
  end
end
