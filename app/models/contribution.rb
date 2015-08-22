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
    after_transition initiated: :scheduled do |contribution, _|
      JarMailer.scheduled_email(contribution).deliver_later
    end
    after_transition scheduled: :completed do |contribution, _|
      JarMailer.completed_email(contribution).deliver_later
    end
    event :success do
      transition scheduled: :completed, initiated: :scheduled
    end

    event :error do
      transition initiated: :failed,  scheduled: :failed
    end

    event :retry do
      transition schedule_failed: :initiated, failed: :scheduled
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
end
