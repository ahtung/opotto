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

  # retuns the fullness value
  def fullness
    total_contribution / 100
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

  private

  # email guests about payout
  def notify_payout
    UserMailer.payout_email(owner, self).deliver_now
  end
end
