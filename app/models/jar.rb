class Jar < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :contributions, :dependent => :destroy
  has_many :contributors, through: :contributions, source: :user
end
