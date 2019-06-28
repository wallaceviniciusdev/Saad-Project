class StudyCasesController < ApplicationController
  before_action :set_study_case, only: [:show, :edit, :update, :destroy]
  autocomplete :study_case, :title, :full => true

  def check_privilege(study_case)
     unless current_user.type == "Teacher"
      redirect_to welcome_index_path
      return
    end
  end
  # GET /study_cases
  # GET /study_cases.json
  def index
    @study_cases = StudyCase.all
  end

  # GET /study_cases/1
  # GET /study_cases/1.json
  def show
    check_privilege(@study_case)
    @questions = @study_case.questions
    respond_to do |format|
        format.html { render :show }
        format.js { render :show }
      end 
  end
  def search2
    @knowledges = Knowledge.all.collect { |knowledge| knowledge.descricao }
    @main_themes = MainTheme.all.collect{|maintheme| maintheme.descricao}
  end

  def list2
    if params[:tema_principal] == "todos" && params[:area_do_conhecimento] == "todos"
      @study_cases = StudyCase.all
    elsif params[:tema_principal] == "todos" && params[:area_do_conhecimento] != "todos"
      @study_cases = StudyCase.where(area: params[:area_do_conhecimento])
    elsif params[:tema_principal] != "todos" && params[:area_do_conhecimento] == "todos"
      @study_cases = StudyCase.where(topic: params[:tema_principal])
    else
      @study_cases = StudyCase.where(topic: params[:tema_principal], area: params[:area_do_conhecimento])
    end 
  end
  # GET /study_cases/new
  def new
    @study_case = StudyCase.new
    @ke = Knowledge.all
    @knowledges = @ke.collect { |knowledge| knowledge.descricao }
    @mt= MainTheme.all
    @main_themes = @mt.collect{|maintheme| maintheme.descricao}
    
  end

  # GET /study_cases/1/edit
  def edit
    check_privilege(@study_case)
    @ke = Knowledge.all
    @knowledges = @ke.collect { |knowledge| knowledge.descricao }
    @mt= MainTheme.all
    @main_themes = @mt.collect{|maintheme| maintheme.descricao}

  end

  def search

  end

  def list
    @study_cases = StudyCase.where("title ilike ?", params[:title])
  end

  # POST /study_cases
  # POST /study_cases.json
  def create
    @study_case = StudyCase.new(study_case_params)
    @study_case.user = current_user
    @study_case.recommended = params[:recommended].to_sentence
    if params[:relat]
      if params[:relat][:atu] == 'yes'
        @reference = Reference.new
        @reference.text = params[:reference]
        @reference.study_case = @study_case
        @reference.save
      end
    end
    respond_to do |format|
      if @study_case.save
        format.html { redirect_to @study_case, notice: 'O estudo de caso foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @study_case }
      else
        format.html { render :new }
        format.json { render json: @study_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_cases/1
  # PATCH/PUT /study_cases/1.json
  def update
    respond_to do |format|
      if @study_case.update(study_case_params)
        format.html { redirect_to @study_case, notice: 'Study case was successfully updated.' }
        format.json { render :show, status: :ok, location: @study_case }
      else
        format.html { render :edit }
        format.json { render json: @study_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_cases/1
  # DELETE /study_cases/1.json
  def destroy
    check_privilege(@study_case)
    @study_case.destroy
    respond_to do |format|
      format.html { redirect_to study_cases_url, notice: 'Study case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_case
      @study_case = StudyCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def study_case_params
      params.require(:study_case).permit(:title, :author, :area, :topic, :topic2, :recommended, :abstract, :case_file, :notes_file)
    end
end
