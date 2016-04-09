# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user
  after_action :verify_authorized

  # GET /:id
  def show
  end

  private

  def set_user
    @user = current_user.decorate
  end

  def authorize_user
    authorize @user
  end
end
