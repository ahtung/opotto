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
    true
  end

  # contribute?
  def contribute?
    jar.guests.include?(user) && jar.open?
  end

  # new?
  def new?
    true
  end

  # edit?
  def edit?
    true
  end

  # create?
  def create?
    true
  end

  # update?
  def update?
    jar.owner == user
  end
end