# PotsController
class PotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pot, only: [:show, :edit, :update, :destroy, :report]
  before_action :authorize_pot, except: [:new, :create, :report, :update]
  after_action :verify_authorized, except: [:new, :create, :report, :update]

  decorates_assigned :pot

  # GET /pots/1
  def show
  end

  # GET /pots/new
  def new
    @pot = Pot.new
  end

  # GET /pots/1/edit
  def edit
  end

  # GET /pots/1/report
  def report
    @abuse = @pot.reported_abuses.create
    redirect_to @pot, notice: t('pot.reported')
  end

  # POST /pots
  def create
    @pot = current_user.pots.build(pot_params)
    if verify_recaptcha(model: @pot) && @pot.save
      Rails.logger.info("Payment log | Pot is created, will end at #{@pot.end_at}")
      redirect_to @pot, notice: t('pot.created')
    else
      render :new
    end
  end

  # PATCH/PUT /pots/1
  def update
    if @pot.update(pot_params)
      redirect_to @pot, notice: t('pot.updated')
    else
      render :edit
    end
  end

  private

  # authorize_pot
  def authorize_pot
    authorize @pot
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_pot
    @pot = Pot.includes(contributions: :user).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pot_params
    params.require(:pot).permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: [])
  end
end
