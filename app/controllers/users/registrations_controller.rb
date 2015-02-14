# Users::RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # devise redirect path after user sign up
  def after_sign_up_path_for(resource)
    authenticated_root_path(resource)
  end

  # devise redirect path after user registration update
  def after_update_path_for(resource)
    authenticated_root_path(resource)
  end
end
