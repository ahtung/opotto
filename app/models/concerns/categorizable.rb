# app/models/concerns/categorizable.rb
module Categorizable
  extend ActiveSupport::Concern

  included do
    # Constants
    CATEGORIES = %w(home student gift plane diamond truck trophy heart).freeze

    # Enums
    enum category: CATEGORIES

    # Validations
    validates :category, presence: true
  end

  def category_color
    case category
    when 'home' then 'red'
    when 'student' then 'orange'
    when 'gift' then 'yellow'
    when 'plane' then 'olive'
    when 'diamond' then 'green'
    when 'truck' then 'teal'
    when 'trophy' then 'blue'
    when 'heart' then 'violet'
    end
  end
end
