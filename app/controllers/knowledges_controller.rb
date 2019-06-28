class KnowledgesController < ApplicationController
  before_action :set_knowledge, only: [:show, :edit, :update, :destroy]

  # GET /knowledges
  # GET /knowledges.json
  def index
    @knowledges = Knowledge.all
  end

  # GET /knowledges/1
  # GET /knowledges/1.json
  def show
  end

  # GET /knowledges/new
  def new
    @knowledge = Knowledge.new
  end

  # GET /knowledges/1/edit
  def edit
  end

  # POST /knowledges
  # POST /knowledges.json
  def create
    @knowledge = Knowledge.new(knowledge_params)

    respond_to do |format|
      if @knowledge.save
        format.html { redirect_to knowledges_path  , notice: 'Área do conhecimento cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @knowledge }
      else
        format.html { render :new }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knowledges/1
  # PATCH/PUT /knowledges/1.json
  def update
    respond_to do |format|
      if @knowledge.update(knowledge_params)
        format.html { redirect_to knowledges_path  , notice: 'Área do conhecimento atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @knowledge }
      else
        format.html { render :edit }
        format.json { render json: @knowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledges/1
  # DELETE /knowledges/1.json
  def destroy
    @knowledge.destroy
    respond_to do |format|
      format.html { redirect_to knowledges_url, notice: 'Knowledge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge
      @knowledge = Knowledge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knowledge_params
      params.require(:knowledge).permit(:descricao)
    end
end
