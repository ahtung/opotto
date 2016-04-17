# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name
    h.content_tag :h2 do
      h.concat h.content_tag :span, object.name
      h.concat " "
      h.concat h.content_tag :span, object.name
    end
  end
end
