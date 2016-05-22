# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name
    h.content_tag :h2 do
      h.concat h.content_tag :span, object.first_name
      h.concat " "
      h.concat h.content_tag :span, object.last_name
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
