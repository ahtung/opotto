# ContributionsController
class ContributionsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user!
  before_action :set_pot, only: [:new, :create]
  before_action :authorize_pot
  after_action :verify_authorized

  decorates_assigned :pot

  # GET /contributions/new
  def new
    @contribution = @pot.contributions.build
  end

  # POST /contributions
  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user = current_user
    if @contribution.save
      redirect_to('http://www.google.com')
    else
      render :new
    end
  end

  private

  # authorize user from contributing to a pot
  def authorize_pot
    authorize @pot, :contribute?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_pot
    @pot = Pot.find(params[:pot_id])
  end

  # Strong params
  def contribution_params
    params.require(:contribution).permit(:pot_id, :amount, :anonymous)
  end
end
