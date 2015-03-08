# HomeController
class HomeController < ApplicationController
  before_action :authenticate_user!, only: :index
  # GET /
  def index
    @jars = current_user.discoverable_jars
  end

  # GET /welcome
  def welcome
  end
end
