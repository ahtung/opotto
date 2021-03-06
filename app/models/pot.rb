# Pot
class Pot < ActiveRecord::Base
  include DateTimeAttribute
  include Abusable
  include Categorizable

  # Constant
  IMMUTABLE = %w(receiver_id end_at).freeze

  # Relations
  belongs_to :owner, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :contributions, dependent: :destroy
  has_many :contributors, -> { distinct }, through: :contributions, source: :user
  has_many :invitations, dependent: :destroy
  has_many :guests, -> { distinct }, through: :invitations, source: :user

  # Validations
  validates :owner, presence: true
  validates :receiver, presence: true
  validates :name, presence: true, uniqueness: true
  validates :end_at, presence: true
  validates_datetime :end_at, on: :create, between: [Time.zone.now, Time.zone.now + 90.days]
  validate :receiver_not_a_guest, if: -> { receiver }
  validate :owners_pot_count, if: -> { owner }
  validate :yearly_pot_limit, if: -> { owner }
  validate :force_immutable

  date_time_attribute :end_at

  monetize :upper_bound_cents, allow_nil: true

  default_scope { includes(:owner) }
  scope :this_week, -> { where('created_at >= ?', 1.week.ago.in_time_zone).where('created_at <= ?', Time.zone.now) }

  # Validates owner's pot count
  def owners_pot_count
    pot_per_person = ENV['POT_PER_USER'] ? ENV['POT_PER_USER'].to_i : 2
    return unless owner.pots.open.count > pot_per_person
    errors.add(:base, "Can't have more than #{pot_per_person} pots")
  end

  # Validates that the receiver is not in guest list
  def receiver_not_a_guest
    return unless guests.include?(receiver)
    errors.add(:guests, "Receiver can't be a guest")
  end

  # Validates owner's pot's in this year
  def yearly_pot_limit
    yearly_limit = ENV['POT_LIMIT_PER_YEAR'] ? ENV['POT_LIMIT_PER_YEAR'].to_i : 4
    pot_count_since_new_year = owner.pots.where('created_at > ?', Time.zone.today.beginning_of_year).count
    return unless pot_count_since_new_year > yearly_limit
    errors.add(:base, "Can't have more than #{yearly_limit} pots in a year")
  end

  # returns the total contribution
  def total_contribution
    contributions.with_states(:scheduled, :completed).map(&:amount).inject { |a, e| a + e } || 0
  end

  # returns the total contribution by user
  def total_contribution_by(user)
    contributions.where(user: user).with_states(:scheduled, :completed).map(&:amount).inject { |a, e| a + e } || 0
  end

  # returns the contributor count
  def total_contributors
    contributors.count
  end

  # returns the guest count
  def total_guests
    guests.count
  end

  def open?
    end_at >= Time.zone.now
  end

  def closed?
    end_at < Time.zone.now && end_at >= 1.week.ago.in_time_zone
  end

  def ended?
    end_at < 1.week.ago.in_time_zone
  end

  # Class methods
  class << self
    # scope for all visible pots
    def visible
      where(visible: true)
    end

    # scope for all open pots
    def open
      where('end_at >= ?', Time.zone.now)
    end

    # scope for all closed pots
    def closed
      where('end_at < ? AND end_at > ?', Time.zone.now, 1.week.ago.in_time_zone)
    end

    # scope for all ended pots
    def ended
      where('end_at <= ?', 1.week.ago.in_time_zone)
    end

    def policy_class
      PotPolicy
    end
  end

  private

  def force_immutable
    return unless persisted?
    IMMUTABLE.any? { |attr| changed.include?(attr) && errors.add(attr, :immutable) }
  end
end
