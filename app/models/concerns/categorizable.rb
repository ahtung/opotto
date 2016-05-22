# app/models/concerns/categorizable.rb
module Categorizable
  extend ActiveSupport::Concern

  included do
    # Constants
    CATEGORIES = %w(home student gift plane diamond truck trophy heart).freeze
    CATEGORY_COLORS = %w(red orange yellow olive green teal blue violet).freeze

    # Enums
    enum category: CATEGORIES

    # Validations
    validates :category, presence: true
  end

  class_methods do
    def category_color_mapping
      h = {}
      const_get(:CATEGORIES).zip(const_get(:CATEGORY_COLORS)) { |a, b| h[a.to_sym] = b }
      h
    end
  end

  def category_color
    self.class.category_color_mapping[category.to_sym]
  end
end
