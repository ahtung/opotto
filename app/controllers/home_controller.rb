class HomeController < ApplicationController
  def index
    @users_jars = current_user.jars
    @users_contributed_jars = current_user.contributed_jars
    @contributable_jars = Jar.all
  end
end
