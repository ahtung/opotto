# Jar
class Jar < ActiveRecord::Base
  include DateTimeAttribute

  # Relations
  belongs_to :owner, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :contributions, dependent: :destroy
  has_many :contributors, -> { uniq }, through: :contributions, source: :user
  has_many :invitations, dependent: :destroy
  has_many :guests, -> { uniq }, through: :invitations, source: :user

  # Validations
  validates :receiver, presence: true
  validates :name, presence: true, uniqueness: true
  validates :end_at, presence: true
  validates_datetime :end_at, on: :create, between: [Time.zone.now, Time.zone.now + 90.days]
  validate :receiver_not_a_guest
  validate :owners_pot_count, if: -> { owner }
  validate :yearly_pot_limit, if: -> { owner }

  date_time_attribute :end_at

  monetize :upper_bound_cents, allow_nil: true

  default_scope { includes(:owner) }

  # Checks owner's pot count
  def owners_pot_count
    pot_per_person = ENV['POT_PER_USER'] ? ENV['POT_PER_USER'].to_i : 2
    errors.add(:base, "Can't have more than #{pot_per_person} pots") if owner.jars.open.count > pot_per_person
  end

  def yearly_pot_limit
    yearly_limit = ENV['POT_LIMIT_PER_YEAR'].to_i || 4
    jar_count_since_new_year = owner.jars.where('created_at > ?', Date.today.beginning_of_year).count
    errors.add(:base, "Can't have more than #{yearly_limit} pots in a year") if jar_count_since_new_year > yearly_limit
  end

  # retuns the fullness value
  def fullnes
    total_contribution.to_f / 1000
  end

  # returns the total contribution
  def total_contribution
    contributions.complete.map(&:amount).inject { |a, e| a + e } || 0
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

  # Class methods
  class << self
    # scope for all visible jars
    def visible
      where(visible: true)
    end

    # scope for all open jars
    def open
      where('end_at >= ?', Time.zone.now)
    end

    # scope for all closed jars
    def closed
      where('end_at < ?', Time.zone.now)
    end

    # scope for all ended jars
    def ended
      where('end_at <= ?', 7.days.ago)
    end

    def policy_class
      JarPolicy
    end
  end
  # Gives an array of 12 points coordinates
  def pot_points
    key = Digest::SHA1.hexdigest name
    coordinates = convert_to_ascii(key)
    reversed_coordinates = coordinates.reverse.map do |point|
      { x: 200 - point[:x], y: point[:y] }
    end
    coordinates + reversed_coordinates
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

  # Validates that the receiver is not in guest list
  def receiver_not_a_guest
    errors.add(:guests, "Receiver can't be a guest") if guests.include?(receiver)
    true
  end
end
