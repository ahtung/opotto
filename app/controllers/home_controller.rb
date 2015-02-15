# HomeController
class HomeController < ApplicationController
  # GET /
  def index
    @jars = Jar.all
  end

  # GET /welcome
  def welcome
  end
end
