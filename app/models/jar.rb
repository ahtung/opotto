class Jar < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :contributions, :dependent => :destroy
  has_many :contributors, -> {uniq}, through: :contributions, source: :user
  
  def total_contribution
    contributions.sum("amount")
  end
  
  def total_contributors
    contributors.count
  end
end
