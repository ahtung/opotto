# JarPolicy
class JarPolicy
  attr_reader :user, :jar

  # init policy
  def initialize(user, jar)
    @user = user
    @jar = jar
  end

  # show?
  def show?
    user && (jar.visible? || jar.guests.include?(user) || jar.owner == user)
  end

  # contribute?
  def contribute?
    user && jar.open?
  end

  # edit?
  def edit?
    jar.owner == user
  end

  # update?
  def update?
    jar.owner == user
  end
end
