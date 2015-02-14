# Users::PasswordsController
class Users::PasswordsController < Devise::PasswordsController
  protected

  # devise redirect path after user resetting password
  def after_resetting_password_path_for(resource)
    authenticated_root_path(resource)
  end
end
