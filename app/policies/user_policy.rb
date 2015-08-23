# UserPolicy
class UserPolicy
  attr_reader :user, :current_user

  # init policy
  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  # show?
  def show?
    current_user == user
  end
end
