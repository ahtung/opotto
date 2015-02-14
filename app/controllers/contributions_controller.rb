# ContributionsController
class ContributionsController < ApplicationController
  before_action :set_jar, only: [:new, :show, :edit, :update, :destroy]

  # GET /contributions/new
  def new
    @contribution = @jar.contributions.build
  end

  # POST /contributions
  def create
    @contribution = current_user.contributions.build(contribution_params)

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to root_path, notice: 'Contribution was successfully created.' }
        format.json { render :show, status: :created, location: @contribution }
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
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
