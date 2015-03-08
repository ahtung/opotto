# Contribution
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :jar

  validate :amount_inside_the_pot_bounds

  monetize :amount_cents

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

  private

  def amount_inside_the_pot_bounds
    return true unless jar.upper_bound
    return true if jar.total_contribution + amount <= jar.upper_bound
    raise "Unable to..."
  end

end
