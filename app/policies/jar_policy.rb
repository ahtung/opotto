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
    user
  end

  # contribute?
  def contribute?
    user && jar.open?
  end

  # new?
  def new?
    user
  end

  # edit?
  def edit?
    jar.owner == user
  end

  # create?
  def create?
    user
  end

  # update?
  def update?
    jar.owner == user
  end
end