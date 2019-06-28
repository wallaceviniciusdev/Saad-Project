class CampusController < ApplicationController
  before_action :set_campu, only: [:show, :edit, :update, :destroy]
  autocomplete :campu, :name, :full => true
  # GET /campus
  # GET /campus.json
  def index
    if current_user.type == "Administrator"
      @campus = Campu.all
    elsif current_user.type == 'Principal'
      @campus = Campu.where(institution_id: current_user.institution.id)
    end
  end

  # GET /campus/1
  # GET /campus/1.json
  def show
    @centers = Center.where(campu_id: @campu.id).find_each
    @center = Center.new
  end

  # GET /campus/new
  def new
    @campu = Campu.new
    if current_user.type == "Principal"
      @institution = current_user.institution
    end
  end

  # GET /campus/1/edit
  def edit
    @campu = Campu.find(params[:id])
    @institution = @campu.institution
  end

  # POST /campus
  # POST /campus.json
  def create
    @campu = Campu.new(campu_params)

    respond_to do |format|
      if @campu.save
        format.html { redirect_to @campu.institution, notice: 'Campus cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @campu }
      else
        format.html { render :new }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campus/1
  # PATCH/PUT /campus/1.json
  def update
    respond_to do |format|
      if @campu.update(campu_params)
        format.html { redirect_to @campu, notice: 'Campus atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @campu }
      else
        format.html { render :edit }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campus/1
  # DELETE /campus/1.json
  def destroy
    @campu.destroy
    respond_to do |format|
      format.html { redirect_to campus_url, notice: 'Campu deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campu
      @campu = Campu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campu_params
      params.require(:campu).permit(:name, :institution_id)
    end
end
