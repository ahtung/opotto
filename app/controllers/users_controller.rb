# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /:id
  def show
    @user = current_user
  end
end
