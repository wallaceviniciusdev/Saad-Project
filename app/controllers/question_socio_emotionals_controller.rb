class QuestionSocioEmotionalsController < ApplicationController
  before_action :set_question_socio_emotional, only: [:show, :edit, :update, :destroy]
require 'set'
require 'csv'
  # GET /question_socio_emotionals
  # GET /question_socio_emotionals.json
  def index
    @question_socio_emotionals = QuestionSocioEmotional.all
  end

  def setup_teacher_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @institution = Institution.find(current_user.institution_id)
    @course = Course.find(current_user.course_id)
    @center = @course.center
    @campu = @center.campu
    @classrooms = current_user.classrooms
    @institutions << @institution
    @courses << @course
    @centers << @center 
    @campus << @campu
    @subjects = []
    @students = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}

  end


def setup_principal_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @subjects = []
    @classrooms = []
    @students = []
    @institution = Institution.find(current_user.institution_id)
    @campus = current_user.campus
    @campus.each do |campu|
      pre = Center.where(campu: campu).load
      pre.each do |p|
        if not p.nil?
          @centers << p
        end
      end 
    end
    @centers.each do |center|
      pre = Course.where(center: center).load
      pre.each do |p|
        if not p.nil?
          @courses << p
        end
      end
    end
    @courses.each do |course|
      pre = Subject.where(course: course).load
      pre.each do |p|
        if not p.nil?
          @subjects << p
        end
      end
    end
    @subjects.each do |subject|
      pre = Classroom.where(subject: subject).load
       pre.each do |p|
        if not p.nil?
          @classrooms << p
        end
      end
    end
    @classrooms.each do |classroom|
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @students = @students.uniq { |s| s.nome}
  end

  # GET /question_socio_emotionals/1
  # GET /question_socio_emotionals/1.json
  def show
    @creator = User.where(id: @question_socio_emotional.creator_id).first
  end

  # GET /question_socio_emotionals/new
  def new
    @question_socio_emotional = QuestionSocioEmotional.new
    if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end
  
  # GET /question_socio_emotionals/1/edit
  def edit
  end
 
  # POST /question_socio_emotionals
  # POST /question_socio_emotionals.json
  def create
    @question_socio_emotional = QuestionSocioEmotional.new(question_socio_emotional_params)
    @users = User.all
    @question_socio_emotional.data_final = DateTime.now.to_date
    @users.each do |user|
        @equal = false
        @user_question_socio_emotionals = user.quizzes 
        if @user_question_socio_emotionals.size > 0
            @user_question_socio_emotionals.each do |user_question_socio_emotional|
              if user_question_socio_emotional.data_final == @question_socio_emotional.data_final
                @equal = true
              end
            end
            if @equal == false && user.approved == true
                    @question_socio_emotional.users << user
            end
        elsif user.approved == true
          @question_socio_emotional.users << user
        end
    end
     respond_to do |format|
      if @question_socio_emotional.save
        format.html { redirect_to welcome_index_path, notice: 'Questionario de competências socioemocionais criado com sucesso.' }
        format.json { render :show, status: :created, location: @question_socio_emotional }
      else
        format.html { render :new }
        format.json { render json: @question_socio_emotional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_socio_emotionals/1
  # PATCH/PUT /question_socio_emotionals/1.json
  def update
    respond_to do |format|
      if @question_socio_emotional.update(question_socio_emotional_params)
        format.html { redirect_to @question_socio_emotional, notice: 'Question socio emotional was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_socio_emotional }
      else
        format.html { render :edit }
        format.json { render json: @question_socio_emotional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_socio_emotionals/1
  # DELETE /question_socio_emotionals/1.json
  def destroy
    @question_socio_emotional.destroy
    respond_to do |format|
      format.html { redirect_to question_socio_emotionals_url, notice: 'Question socio emotional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_socio_emotional
      @question_socio_emotional = QuestionSocioEmotional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_socio_emotional_params
      params.require(:question_socio_emotional).permit(:user_id, :data_final, :creator_id, :institution_id, :campu_id, :center_id, :course_id, :subject_id, :classroom_id, :users_id)
    end
end
 