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
    when 'home'
      'red'
    when 'student'
      'orange'
    when 'gift'
      'yellow'
    when 'plane'
      'olive'
    when 'diamond'
      'green'
    when 'truck'
      'teal'
    when 'trophy'
      'blue'
    when 'heart'
      'violet'
    end
  end
end
