# Jar
class Jar < ActiveRecord::Base
  include DateTimeAttribute

  belongs_to :owner, class_name: 'User'
  has_many   :contributions, dependent: :destroy
  has_many   :contributors, -> { uniq }, through: :contributions, source: :user
  has_many   :invitations, dependent: :destroy
  has_many   :guests, -> { uniq }, through: :invitations, source: :user

  validates           :name, presence: true, uniqueness: true
  validates           :end_at, presence: true
  validates_datetime  :end_at, on: :create, on_or_after: :today

  date_time_attribute :end_at

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

  # scope for all open jars
  def self.open
    where('end_at >= ?', Date.today)
  end

  # scope for all ended jars
  def self.ended
    where('end_at <= ?', 7.days.ago)
  end
end
