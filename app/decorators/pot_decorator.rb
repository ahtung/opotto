# app/decorators/pot_decorator.rb
class PotDecorator < Draper::Decorator
  delegate_all

  def status
    h.content_tag :div, class: "card-panel #{status_color}" do
      status_text
    end
  end

  def humanized_total_contribution
    h.humanized_money_with_symbol(object.total_contribution)
  end

  def status_color
    return 'yellow' if object.open?
    return 'green' if object.closed?
    return 'orange' if object.ended?
  end

  def status_text
    return 'Open' if object.open?
    return 'Closed' if object.closed?
    return 'Ended' if object.ended?
  end

  def category_icon
    h.content_tag :i, '', class: "big #{object.category_color} icon #{object.category}"
  end
end
