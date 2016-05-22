# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name(separator, icon = false)
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{icon}" if icon
      h.concat h.content_tag :span, object.first_name.upcase, class: 'green-text'
      h.concat separator
      h.concat h.content_tag :span, object.last_name, class: 'grey-text'
    end
  end

  def handle
    if object.name
      object.name
    else
      object.email.match(/^(.*)@.*$/)[1]
    end
  end
end
