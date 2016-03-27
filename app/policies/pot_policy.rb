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
    user && (pot.visible? || pot.guests.include?(user) || pot.owner == user)
  end

  # contribute?
  def contribute?
    user && pot.open?
  end

  # edit?
  def edit?
    pot.owner == user
  end

  # update?
  def update?
    pot.owner == user
  end
end
