# HomeController
class HomeController < ApplicationController
  before_action :authenticate_user!, only: :index
  # GET /
  def index
    @jars = Jar.all
  end

  # GET /welcome
  def welcome
  end
end
