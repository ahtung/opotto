# Jar
class Jar < ActiveRecord::Base
  include DateTimeAttribute

  # Relations
  belongs_to :owner, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many   :contributions, dependent: :destroy
  has_many   :contributors, -> { uniq }, through: :contributions, source: :user
  has_many   :invitations, dependent: :destroy
  has_many   :guests, -> { uniq }, through: :invitations, source: :user

  # Validations
  validates           :receiver, presence: true
  validates           :name, presence: true, uniqueness: true
  validates           :end_at, presence: true
  validates_datetime  :end_at, on: :create, on_or_after: :today
  validate            :receiver_not_a_guest

  date_time_attribute :end_at

  # retuns the fullness value
  def fullness
    total_contribution.to_f / 1000
  end

  # returns the total contribution
  def total_contribution
    contributions.map(&:amount).inject { |sum, x| sum + x } || 0
  end

  # returns the contributor count
  def total_contributors
    contributors.count
  end

  # returns the guest count
  def total_guests
    guests.count
  end

  # payout and notify guests
  def payout
    # TODO
    update_attribute(:paid_at, Date.today)
    notify_payout
  end

  def open?
    end_at >= Date.today
  end

  # Class methods
  class << self
    # scope for all visible jars
    def visible
      where(visible: true)
    end

    # scope for all open jars
    def open
      where('end_at >= ?', Date.today)
    end

    # scope for all closed jars
    def closed
      where('end_at < ?', Date.today)
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
      { x: 200 - point[:x] , y: point[:y] }
    end
    coordinates + reversed_coordinates
  end

  private

  # email guests about payout
  def notify_payout
    UserMailer.payout_email(owner, self).deliver_now
  end

  # Converts key's each character to ascii, creates an array with 6 points
  def convert_to_ascii(key)
    coords = []
    byteCounter = 0
    key.first(6).each_byte do |c, index|
      coords << { x: scaled_coordinate(c.to_i), y: byteCounter * 40 }
      byteCounter = byteCounter + 1
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
