# ApplicationController
class ApplicationController < ActionController::Base
  around_filter :set_time_zone
  protect_from_forgery
  include Pundit

  include HttpAcceptLanguage::AutoLocale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.user_not_authorized')
    redirect_to(request.referrer || root_path)
  end

  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = browser_timezone if browser_timezone.present?
    yield
  ensure
    Time.zone = old_time_zone
  end

  def browser_timezone
    cookies["browser.timezone"]
  end
end
