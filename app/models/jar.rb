# Jar
class Jar < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :contributions, dependent: :destroy
  has_many :contributors, -> { uniq }, through: :contributions, source: :user

  validates :name, presence: true, uniqueness: true

  # returns the total contribution
  def total_contribution
    contributions.map(&:amount).inject { |sum, x| sum + x } || 0
  end

  # returns the contributor count
  def total_contributors
    contributors.count
  end
end
