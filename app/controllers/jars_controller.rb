# JarsController
class JarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jar, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /jars/1
  def show
    authorize @jar
  end

  # GET /jars/new
  def new
    authorize Jar
    @jar = Jar.new
  end

  # GET /jars/1/edit
  def edit
    authorize @jar
  end

  # POST /jars
  def create
    @jar = current_user.jars.build(jar_params)
    authorize @jar
    if @jar.save
      redirect_to root_path, notice: t('jar.created')
    else
      render :new
    end
  end

  # PATCH/PUT /jars/1
  def update
    authorize @jar
    if @jar.update(jar_params)
      redirect_to root_path, notice: t('jar.updated')
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jar
    @jar = Jar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jar_params
    params.require(:jar).permit(:name, :end_at_date, :end_at_time, guest_ids: [])
  end
end
