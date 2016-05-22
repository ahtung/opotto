# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name(separator = false, icon = false)
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{icon}" if icon
      h.concat h.content_tag :span, object.first_name.upcase, class: 'green-text'
      h.concat (separator ? separator : ' ')
      h.concat h.content_tag :span, object.last_name, class: 'grey-text'
    end
  end

  def highlighted_email(icon = false)
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{icon}" if icon
      h.concat h.content_tag :span, object.email.match(/^(.*)@.*$/)[1], class: 'green-text'
    end
  end

  def handle(seperator = false, icon = false)
    if object.name?
      highlighted_name(seperator, icon)
    else
      highlighted_email(icon)
    end
  end
end
