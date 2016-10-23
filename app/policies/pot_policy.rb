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
    condition = pot.owner == user || pot.guests.include?(user) || pot.visible?
    return false if user.nil?
    return pot.open? if condition
    false
  end

  # edit?
  def edit?
    return false if user.nil?
    return false if pot.persisted?
    pot.owner == user
  end

  # update?
  def update?
    return false if user.nil?
    return false if pot.persisted?
    pot.owner == user
  end

  # destroy?
  def destroy?
    return false if user.nil?
    return false if pot.new_record?
    return true if pot.owner == user
    false
  end
end
