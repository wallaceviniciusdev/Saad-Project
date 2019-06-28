class OpportunityAnswersController < ApplicationController
  before_action :set_opportunity_answer, only: [:show, :edit, :update, :destroy]

  # GET /opportunity_answers
  # GET /opportunity_answers.json
  def index
    @opportunity_answers = OpportunityAnswer.all
  end

  # GET /opportunity_answers/1
  # GET /opportunity_answers/1.json
  def show
  end

  # GET /opportunity_answers/new
  def new
    @opportunity_answer = OpportunityAnswer.new
  end

  # GET /opportunity_answers/1/edit
  def edit
    @plano = current_user.plano
    respond_to do |format|
      format.js
    end
  end

  # POST /opportunity_answers
  # POST /opportunity_answers.json
  def create
    @opportunity_answer = OpportunityAnswer.new(opportunity_answer_params)
    @opportunity = Opportunity.find(@opportunity_answer.opportunity)
    @plano = current_user.plano
    @opportunities = @plano.opportunities

    respond_to do |format|
      if @opportunity_answer.save
        format.html { redirect_to @opportunity_answer, notice: 'Opportunity answer was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity_answer }
        format.js
      else
        format.html { render :new }
        format.json { render json: @opportunity_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunity_answers/1
  # PATCH/PUT /opportunity_answers/1.json
  def update
    respond_to do |format|
      hash2 = { text: params[:text], opportunity_id: params[:opportunity_id]}
      if @opportunity_answer.update(hash2)
        format.html { redirect_to student_area_my_plan_path, notice: 'Resposta a oportunidade atualizada.' }
        format.json { render :show, status: :ok, location: @opportunity_answer }
      else
        format.html { render :edit }
        format.json { render json: @opportunity_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunity_answers/1
  # DELETE /opportunity_answers/1.json
  def destroy
    @opportunity_answer.destroy
    @plano = current_user.plano
    @opportunities = @plano.opportunities
    respond_to do |format|
      format.html { redirect_to opportunity_answers_url, notice: 'Opportunity answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity_answer
      @opportunity_answer = OpportunityAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_answer_params
      params.require(:opportunity_answer).permit(:text, :opportunity_id)
    end
end
