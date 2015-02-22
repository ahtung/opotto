# ContributionsController
class ContributionsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_user!
  before_action :set_jar, only: [:new, :create]
  after_action :verify_authorized

  # GET /contributions/new
  def new
    authorize @jar, :contribute?
    @contribution = @jar.contributions.build
  end

  # POST /contributions
  def create
    authorize @jar, :contribute?
    @contribution = current_user.contributions.build(contribution_params)

    if @contribution.save
      redirect_to root_path, notice: t('contribution.created', name: @contribution.jar.name, amount: number_to_currency(@contribution.amount))
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
