# Application Helper
module ApplicationHelper
  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+#{sets_of_numbers.join('-')}"
    number_text = "+#{sets_of_numbers.join(' ')}"
    link_to number_text, "tel://#{number}"
  end
end
