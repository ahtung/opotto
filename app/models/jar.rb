class Jar < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :contributions, dependent: :destroy
  has_many :contributors, -> { uniq }, through: :contributions, source: :user

  validates :name, presence: true, uniqueness: true

  def total_contribution
    (contributions.sum("amount") / 100).to_f
  end

  def total_contributors
    contributors.count
  end
end
