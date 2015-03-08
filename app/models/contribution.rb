# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10_000
  }

  # Returns the proper user name
  def owner_name
    if anonymous?
      'N/A'
    elsif !user.name
      user.email
    else
      user.name
    end
  end
end
