# JarPolicy
class JarPolicy
  attr_reader :user, :post

  # init policy
  def initialize(user, jar)
    @user = user
    @jar = jar
  end

  # update?
  def update?
    jar.owner == user
  end

  # contribute?
  def contribute?
    jar.guests.include?(user) && jar.open?
  end
end