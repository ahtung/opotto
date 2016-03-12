# JarsController
class JarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jar, only: [:show, :edit, :update, :destroy, :report]
  before_action :authorize_jar, except: [:new, :create, :report]
  after_action :verify_authorized, except: [:new, :create, :report]

  # GET /jars/1
  def show
  end

  # GET /jars/new
  def new
    @jar = Jar.new
  end

  # GET /jars/1/edit
  def edit
  end

  # GET /jars/1/report
  def report
    @abuse = @jar.reported_abuses.new
    if @abuse.save
      redirect_to @jar, notice: t('jar.reported')
    else
      redirect_to @jar, notice: t('jar.not_reported')
    end
  end

  # POST /jars
  def create
    @jar = current_user.jars.build(jar_params)
    if verify_recaptcha(model: @jar) && @jar.save
      Rails.logger.info("Payment log | Pot is created, will end at #{@jar.end_at}")
      redirect_to @jar, notice: t('jar.created')
    else
      render :new
    end
  end

  # PATCH/PUT /jars/1
  def update
    if @jar.update(jar_params)
      redirect_to @jar, notice: t('jar.updated')
    else
      render :edit
    end
  end

  private

  # authorize_jar
  def authorize_jar
    authorize @jar
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_jar
    @jar = Jar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jar_params
    params.require(:jar).permit(:name, :end_at, :description, :visible, :upper_bound, :receiver_id, guest_ids: [])
  end
end
