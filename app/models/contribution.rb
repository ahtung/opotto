# COntribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_000
  }
end
