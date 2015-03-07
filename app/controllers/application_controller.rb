# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.user_not_authorized')
    redirect_to root_path
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
