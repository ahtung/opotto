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
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def authorize_user
    authorize @user
  end
end
