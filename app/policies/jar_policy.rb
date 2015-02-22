class JarPolicy
  attr_reader :user, :post

  def initialize(user, jar)
    @user = user
    @jar = jar
  end

  def update?
    jar.owner == user
  end

  def contribute?
    jar.guests.include?(user) && jar.open?
  end
end