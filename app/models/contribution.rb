# COntribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  monetize :amount
end
