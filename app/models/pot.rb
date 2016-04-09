# Pot
class Pot < ActiveRecord::Base
  include DateTimeAttribute
  include Abusable

  # Constant
  IMMUTABLE = %w(name receiver_id description end_at).freeze

  # Relations
  belongs_to :owner, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :contributions, dependent: :destroy
  has_many :contributors, -> { uniq }, through: :contributions, source: :user
  has_many :invitations, dependent: :destroy
  has_many :guests, -> { uniq }, through: :invitations, source: :user

  # Validations
  validates :owner, presence: true
  validates :receiver, presence: true
  validates :name, presence: true, uniqueness: true
  validates :end_at, presence: true
  validates_datetime :end_at, on: :create, between: [Time.zone.now, Time.zone.now + 90.days]
  validate :receiver_not_a_guest, if: -> { receiver }
  validate :owners_pot_count, if: -> { owner }
  validate :yearly_pot_limit, if: -> { owner }
  validate :owners_paypal_country, if: -> { owner }
  validate :force_immutable

  date_time_attribute :end_at

  monetize :upper_bound_cents, allow_nil: true

  default_scope { includes(:owner) }
  scope :this_week, -> { where('created_at >= ?', 1.week.ago.in_time_zone).where('created_at <= ?', Time.zone.now) }

  # Validates whether the owner is from an Crowdfunding allowing country
  def owners_paypal_country
    return unless DISALLOWED_COUNTRIES.include?(owner.paypal_country)
    errors.add(:base, 'Fundraising is prohibited in your country')
  end

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

  # Converts key's each character to ascii, creates an array with 6 points
  def convert_to_ascii(key)
    coords = []
    byte_counter = 0
    key.first(6).each_byte do |c, _|
      coords << { x: scaled_coordinate(c.to_i), y: byte_counter * 40 }
      byte_counter += 1
    end
    coords
  end

  # Scales the ascii number to 100
  def scaled_coordinate(coordinate)
    coordinate * 100 / 255
  end

  def force_immutable
    return unless persisted?
    IMMUTABLE.any? { |attr| changed.include?(attr) && errors.add(attr, :immutable) }
  end
end
