# ErrorsController
class ErrorsController < ApplicationController
  include Gaffe::Errors

  layout 'application'

  skip_before_action :authenticate_user!

  def show
    render "errors/#{@rescue_response}", status: @status_code
  end
end
