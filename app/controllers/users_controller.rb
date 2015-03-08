# UsersController
class UsersController < ApplicationController

  # GET /:id
  def show
    @user = User.find(params[:id])
  end
end