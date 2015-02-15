# JarsController
class JarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jar, only: [:show, :edit, :update, :destroy]

  # GET /jars/1
  def show
  end

  # POST /jars/1/contribute
  def contribute
  end

  # GET /jars/new
  def new
    @jar = Jar.new
  end

  # GET /jars/1/edit
  def edit
  end

  # POST /jars
  def create
    @jar = current_user.jars.build(jar_params)

    if @jar.save
      redirect_to root_path, notice: 'Jar was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /jars/1
  def update
    if @jar.update(jar_params)
      redirect_to root_path, notice: 'Jar was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /jars/1
  def destroy
    @jar.destroy
    redirect_to root_path, notice: 'Jar was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jar
    @jar = Jar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jar_params
    params.require(:jar).permit(:name)
  end
end
