# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name
    h.content_tag :p do
      h.concat h.content_tag :span, object.first_name.upcase, class: 'green-text'
      h.concat h.content_tag :br
      h.concat h.content_tag :span, object.last_name, class: 'blue-text'
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
