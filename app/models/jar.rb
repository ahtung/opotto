class Jar < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :contributions, :dependent => :destroy
  has_many :contributors, -> {uniq}, through: :contributions, source: :user
  
  def self.not_by user
    where.not(owner: user)
  end
  
  def self.not_contributed_by user
    # includes(:contributors).where.not(contributors: user)
    all
  end
  
  def total_contribution
    contributions.sum("amount")
  end
  
  def total_contributors
    contributors.count
  end
end
