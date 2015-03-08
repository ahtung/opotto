# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit

  include HttpAcceptLanguage::AutoLocale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.user_not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
