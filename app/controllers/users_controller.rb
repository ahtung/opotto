# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /:id
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
