# -*- coding: utf-8 -*-
# Contribution
class Contribution < ActiveRecord::Base
  # Concerns
  include Payable

  # Relations
  belongs_to :user
  belongs_to :pot

  # Validations
  validate :amount_inside_the_pot_bounds
  validate :limit_per_user_per_pot, if: -> { user }
  validates :pot, presence: true
  validates :user, presence: true
  validate :minimum_amount
  validate :users_contribution_limit, if: -> { user }

  # Attributes
  attr_accessor :authorization_url

  # Scopes
  scope :complete, -> { with_state([:completed, :scheduled]) }
  scope :payable, -> { joins(:pot).where('pots.end_at <= ?', Time.zone.now) }

  # Money
  monetize :amount_cents

  # Validates user's previous contribution total
  def users_contribution_limit
    contribution_limit = ENV['DONATION_PER_USER_PER_PROJECT'] ? ENV['DONATION_PER_USER_PER_PROJECT'].to_i : 200_000
    contributions_so_far = user.contributions.where(pot: pot).sum(:amount_cents)
    return unless contributions_so_far + amount_cents >= contribution_limit
    errors.add(:base, "Contribution limit of #{contribution_limit} reached")
  end

  # States
  state_machine initial: :initiated do
    after_transition initiated: :scheduled do |contribution, _|
      PotMailer.scheduled_email(contribution).deliver_later
    end
    after_transition scheduled: :completed do |contribution, _|
      PotMailer.completed_email(contribution).deliver_later
      contribution.pot.update_attribute :paid_at, Time.zone.now
    end
    after_transition scheduled: :failed do |contribution, _|
      PotMailer.failed_payment_email(contribution).deliver_later
    end
    event :success do
      transition scheduled: :completed, initiated: :scheduled
    end

    event :error do
      transition initiated: :failed, scheduled: :schedule_failed
    end

    event :retry do
      transition schedule_failed: :initiated, failed: :scheduled
    end
  end

  # Returns the proper user name
  def owner_name
    if anonymous? || user.nil?
      'N/A'
    else
      user.handle
    end
  end

  private

  # Checks if contribution amount is less then the limit
  def limit_per_user_per_pot
    contribution_count = user.contributions.where(pot: pot).count
    contribution_limit = ENV['CONTRIBUTION_LIMIT_PER_POT'] ? ENV['CONTRIBUTION_LIMIT_PER_POT'].to_i : 4
    errors.add(:base, "Can't contribute more than #{contribution_limit} times for a pot") if contribution_count > contribution_limit
  end

  def minimum_amount
    errors.add(:amount_cents, :amount_less_than_minimum) if amount_cents < 100
  end
end
