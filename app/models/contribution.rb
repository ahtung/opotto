# Contribution
class Contribution < ActiveRecord::Base
  # Concerns
  include Payable

  # Relations
  belongs_to :user
  belongs_to :jar

  # Validations
  validate :amount_inside_the_pot_bounds

  # Attributes
  attr_accessor :authorization_url

  # Scopes
  scope :complete, -> { with_state(:completed) }

  # States
  state_machine initial: :initiated do
    event :success do
      transition initiated: :completed
    end

    event :fail do
      transition initiated: :failed
    end

    event :retry do
      transition failed: :initiated
    end
  end

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_00
  }

  # Returns the proper user name
  def owner_name
    if anonymous? || user.nil?
      'N/A'
    else
      user.handle
    end
  end

  # class methods
  class << self
    # scope for completed contibutions
    def completed
      where(status: 'completed')
    end
  end
end
