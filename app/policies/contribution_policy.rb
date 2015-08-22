# ContributionPolicy
class ContributionPolicy
  attr_reader :user, :contribution

  # init policy
  def initialize(user, contribution)
    @user = user
    @contribution = contribution
  end

  # success
  def success?
    contribution.user == user
  end

  # failure?
  def failure?
    contribution.user == user
  end
end
