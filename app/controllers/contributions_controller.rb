# ContributionsController
class ContributionsController < ApplicationController
  before_action :set_jar, only: [:new, :create]

  # GET /contributions/new
  def new
    @contribution = @jar.contributions.build
  end

  # POST /contributions
  def create
    @contribution = current_user.contributions.build(contribution_params)

    if @contribution.save
      redirect_to root_path, notice: 'Contribution was successfully created.'
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jar
    @jar = Jar.find(params[:jar_id])
  end

  def contribution_params
    params.require(:contribution).permit(:jar_id, :amount)
  end
end
