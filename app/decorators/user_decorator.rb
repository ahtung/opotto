# app/decorators/user_decorator.rb
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :contributed_pots
  decorates_association :invited_pots
  decorates_association :pots

  def highlighted_name(options = {})
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{options[:icon]}" if options[:icon]
      h.concat h.content_tag :span, object.first_name.upcase, class: "#{options[:color]}-text"
      h.concat options[:seperator]
      h.concat h.content_tag :span, object.last_name, class: 'grey-text'
    end
  end

  def highlighted_email(options = {})
    h.content_tag :p do
      h.concat h.content_tag :i, '', class: "icon #{options[:icon]}" if options[:icon]
      h.concat h.content_tag :span, object.email.match(/^(.*)@.*$/)[1], class: "#{options[:color]}-text"
    end
  end

  def handle(seperator = ' ', icon = false, color = 'green')
    options = {
      seperator: seperator,
      icon: icon,
      color: color
    }
    if object.name?
      highlighted_name(options)
    else
      highlighted_email(options)
    end
  end
end
