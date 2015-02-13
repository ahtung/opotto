# users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    authenticated_root_path(resource)
  end

  def after_update_path_for(resource)
    authenticated_root_path(resource)
  end
end