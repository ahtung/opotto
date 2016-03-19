# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit

  include HttpAcceptLanguage::AutoLocale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authorize_country
  around_action :set_time_zone

  private

  def authorize_country
    request_country = request.headers['HTTP_CF_IPCOUNTRY'] || ''
    redirect_to page_path('unsupported') if unsupported_countries.include?(request_country)
  end

  # Redirect visitor to root_path in not authorized
  def user_not_authorized
    flash[:alert] = I18n.t('pundit.user_not_authorized')
    redirect_to(request.referrer || root_path)
  end

  # Set the application time zone based on the browser cookie
  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = browser_timezone if browser_timezone.present?
    yield
  ensure
    Time.zone = old_time_zone
  end

  # Gets the time zone from browser cookie
  def browser_timezone
    cookies['browser.timezone']
  end

  def unsupported_countries
    ENV['UNSUPPORTED_COUNTRIES'] ? ENV['UNSUPPORTED_COUNTRIES'].split(',') : %w(JP TW SG MY IN)
  end
end
