class ErrorsController < ApplicationController
  include Gaffe::Errors

  layout 'application'

  skip_before_filter :authenticate_user!
end
