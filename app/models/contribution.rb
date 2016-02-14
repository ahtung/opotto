# Contribution
class Contribution < ActiveRecord::Base
  # Concerns
  include Payable

  # Relations
  belongs_to :user
  belongs_to :jar

  # Validations
  validate :amount_inside_the_pot_bounds
  validates :jar, presence: true
  validates :user, presence: true
  validates :amount_cents, numericality: { greater_than: 100 }
  validate :users_contribution_limit, if: -> { user }

  # Attributes
  attr_accessor :authorization_url

  # Scopes
  scope :complete, -> { with_state([:completed, :scheduled]) }

  # Money
  monetize :amount_cents

  # Checks user's previous contribution total
  def users_contribution_limit
    contribution_limit = ENV['DONATION_PER_USER_PER_PROJECT'] || 200000
    contributions_so_far = user.contributions.where(jar: jar).sum(:amount_cents)
    if contributions_so_far + amount_cents >= contribution_limit
      errors.add(:base, "Contribution limit of #{contribution_limit} reached")
    end
  end

  # States
  state_machine initial: :initiated do
    after_transition initiated: :scheduled do |contribution, _|
      JarMailer.scheduled_email(contribution).deliver_later
      PaymentsWorker.perform_in(contribution.payment_time, contribution.id)
    end
    after_transition scheduled: :completed do |contribution, _|
      JarMailer.completed_email(contribution).deliver_later
      contribution.jar.update_attribute :paid_at, Time.zone.now
    end
    after_transition scheduled: :failed do |contribution, _|
      JarMailer.failed_payment_email(contribution).deliver_later
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
end
