# ErrorsController
class ErrorsController < ApplicationController
  include Gaffe::Errors

  layout 'application'

  skip_before_action :authenticate_user!
end
