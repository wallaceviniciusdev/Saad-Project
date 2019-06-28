class AtividadeExtrasController < ApplicationController
  before_action :set_atividade_extra, only: [:show, :edit, :update, :destroy]

  # GET /atividade_extras
  # GET /atividade_extras.json
  def index
    @atividade_extras = AtividadeExtra.all
  end

  # GET /atividade_extras/1
  # GET /atividade_extras/1.json
  def show
  end

  # GET /atividade_extras/new
  def new
    AtividadeExtra.close
    @atividade_extra = AtividadeExtra.new
  end

  # GET /atividade_extras/1/edit
  def edit
  end

  # POST /atividade_extras
  # POST /atividade_extras.json
  def create
    @atividade_extra = AtividadeExtra.new(atividade_extra_params)
    respond_to do |format|
      if @atividade_extra.save
        format.html { redirect_to @atividade_extra, notice: 'Atividade criada com sucesso.' }
        format.json { render :show, status: :created, location: @atividade_extra }
      else
        format.html { render :new }
        format.json { render json: @atividade_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atividade_extras/1
  # PATCH/PUT /atividade_extras/1.json
  def update
    respond_to do |format|
      if @atividade_extra.update(atividade_extra_params)
        format.html { redirect_to @atividade_extra, notice: 'Atividade foi atualizada.' }
        format.json { render :show, status: :ok, location: @atividade_extra }
      else
        format.html { render :edit }
        format.json { render json: @atividade_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atividade_extras/1
  # DELETE /atividade_extras/1.json
  def destroy
    if @atividade_extra.answers.length >= 1
      respond_to do |format|
      format.html { redirect_to teachers_area_list_atividades_path , alert: 'Não é possível excluir a atividade pois alguns alunos já responderam.' }
      format.json { head :no_content }
      end
    else
      @atividade_extra.destroy
      respond_to do |format|
        format.html { redirect_to teachers_area_list_atividades_path , notice: 'A atividade foi excluir com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atividade_extra
      @atividade_extra = AtividadeExtra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def atividade_extra_params
      params.require(:atividade_extra).permit(:titulo, :descricao, :data_final, :user_id, :arquivo)
    end
end
