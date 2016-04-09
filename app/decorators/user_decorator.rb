# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots
end
