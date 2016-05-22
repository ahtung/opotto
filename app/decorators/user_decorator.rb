# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name(separator = ' ', icon = false, color)
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{icon}" if icon
      h.concat h.content_tag :span, object.first_name.upcase, class: "#{color}-text"
      h.concat separator
      h.concat h.content_tag :span, object.last_name, class: 'grey-text'
    end
  end

  def highlighted_email(icon = false, color)
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{icon}" if icon
      h.concat h.content_tag :span, object.email.match(/^(.*)@.*$/)[1], class: "#{color}-text"
    end
  end

  def handle(seperator = false, icon = false, color = 'green')
    if object.name?
      highlighted_name(seperator, icon, color)
    else
      highlighted_email(icon, color)
    end
  end
end
