# PotPolicy
class PotPolicy
  attr_reader :user, :pot

  # init policy
  def initialize(user, pot)
    @user = user
    @pot = pot
  end

  # show?
  def show?
    return false if user.nil?
    return true if pot.owner == user
    return true if pot.guests.include?(user)
    pot.visible?
  end

  # contribute?
  def contribute?
    return false if user.nil?
    return pot.open? if pot.owner == user
    return pot.open? if pot.guests.include?(user)
    return pot.open? if pot.visible?
    false
  end

  # edit?
  def edit?
    return false if user.nil?
    return false unless pot.new_record?
    pot.owner == user
  end

  # update?
  def update?
    return false if user.nil?
    return false unless pot.new_record?
    pot.owner == user
  end
end
