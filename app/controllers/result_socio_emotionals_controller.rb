class ResultSocioEmotionalsController < ApplicationController
  before_action :set_result_socio_emotional, only: [:show, :edit, :update, :destroy]

  require 'set'
  require 'csv'

  # GET /result_socio_emotionals
  # GET /result_socio_emotionals.json
  def index
    @result_socio_emotionals = ResultSocioEmotional.all
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
    @anos = []
    @semestres = []
    @classrooms.each do |classroom|
        @subjects << classroom.subject
        classroom.users.each do |user|
              @students << user
        end
    end
    @subjects.uniq!
    @subjects = @subjects.sort_by{ |subject| subject.nome}
    @users = @students
    @students = @students.uniq { |s| s.nome}
    @students = @students.sort_by{ |student| student.nome}
    @students.each {|student| student.nome = student.nome.upcase}

  end

  def setup_principal_search
    @institutions = []
    @courses = []
    @centers = []
    @campus = []
    @subjects = []
    @classrooms = []
    @students = []
    @anos = []
    @semestres = []
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
    @subjects = @subjects.sort_by{ |subject| subject.nome}
    @students = @students.uniq { |s| s.nome}
    @students = @students.sort_by{ |student| student.nome}

  end

  # GET /result_socio_emotionals/1
  # GET /result_socio_emotionals/1.json
  def show
  end
   

  def show_by_date
    @result_socio_emotionals = []
    @allUsers = params[:allUsers]
   
    if  @allUsers == 'false'
        @resultados = params[:result_socio_emotionals]
        @selecao = params[:selecao]
        @resultados.each do |result_socio_emotional|
       
        if params[:data_final]
          pre = ResultSocioEmotional.where(data_final: params[:data_final], id: result_socio_emotional).first
        else
          pre = ResultSocioEmotional.find(result_socio_emotional)
        end
        if not pre.nil?
          @result_socio_emotionals << pre
        end
      end
    end
    if @allUsers == 'true'     
      @x = params[:users]
      @x.each do |i|
         pre = ResultSocioEmotional.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @result_socio_emotionals << pre
            end
        end

    @result_socio_emotionals = @result_socio_emotionals.sort_by{ |result_socio_emotional| result_socio_emotional.user.nome}
    end

    @nomeUsuario = []
    @media_cons_emoc = 0.0
    @media_reg_emoc = 0.0
    @media_cons_soc = 0.0
    @media_aut_emoc = 0.0
    @media_cria_emoc = 0.0
     

    @result_socio_emotionals.each do |result_socio_emotional|
      @nomeUsuario = result_socio_emotional.user.nome
      @media_cons_emoc = result_socio_emotional.cons_emoc
      @media_reg_emoc = result_socio_emotional.reg_emoc
      @media_cons_soc = result_socio_emotional.cons_soc
      @media_aut_emoc = result_socio_emotional.aut_emoc
      @media_cria_emoc = result_socio_emotional.cria_emoc
    end



   if @media_cons_emoc >=0 && @media_cons_emoc < 3

            @nivel_cons_emoc = "baixo"
            @nivel_text_cons_emoc = "baixa"
            @sol_text_cons_emoc = "desenvolver"

        elsif @media_cons_emoc >=3 && @media_cons_emoc < 4

            @nivel_cons_emoc = "médio" 
            @nivel_text_cons_emoc = "média"
            @sol_text_cons_emoc = "melhorar"

        elsif @media_cons_emoc >=4 && @media_cons_emoc <= 5

            @nivel_cons_emoc = "alto" 
            @nivel_text_cons_emoc = "alta"
            @sol_text_cons_emoc = "potencializar"
    end


    if @media_reg_emoc >=0 && @media_reg_emoc < 3

            @nivel_reg_emoc= "baixo" 
            @nivel_text_reg_emoc= "baixa" 
            @sol_text_reg_emoc= "desenvolver" 

        elsif @media_reg_emoc >=3 && @media_reg_emoc < 4

            @nivel_reg_emoc = "médio" 
            @nivel_text_reg_emoc= "media" 
            @sol_text_reg_emoc= "melhorar"

        elsif @media_reg_emoc >=4 && @media_reg_emoc <= 5

            @nivel_reg_emoc = "alto" 
            @nivel_text_reg_emoc= "alta" 
            @sol_text_reg_emoc= "potencializar"
    end


    if @media_cons_soc >=0 && @media_cons_soc < 3

            @nivel_cons_soc= "baixo" 
            @nivel_text_cons_soc= "baixa" 
            @sol_text_cons_soc= " " 

        elsif @media_cons_soc >=3 && @media_cons_soc < 4

            @nivel_cons_soc = "médio" 
            @nivel_text_cons_soc= "média"
             @sol_text_cons_soc= " " 

        elsif @media_cons_soc >=4 && @media_cons_soc <= 5

            @nivel_cons_soc = "alto" 
            @nivel_text_cons_soc= "alta"
             @sol_text_cons_soc= " " 
    end


    if @media_aut_emoc >=0 && @media_aut_emoc < 2.666666667

            @nivel_aut_emoc= "baixo"
            @nivel_text_aut_emoc = "baixa"
            @sol_text_aut_emoc = " "

        elsif @media_aut_emoc >=2.666666667 && @media_aut_emoc < 4

            @nivel_aut_emoc = "médio" 
            @nivel_text_aut_emoc = "média" 
            @sol_text_aut_emoc = " "

        elsif @media_aut_emoc >=4 && @media_aut_emoc <= 5

            @nivel_aut_emoc = "alto" 
            @nivel_text_aut_emoc = "alta"
            @sol_text_aut_emoc = " "


    end


    if @media_cria_emoc >=0 && @media_cria_emoc < 3

            @nivel_cria_emoc= "baixo" 
            @nivel_text_cria_emoc= "baixa"
            @sol_text_cria_emoc= " "

        elsif @media_cria_emoc >=3 && @media_cria_emoc < 4

            @nivel_cria_emoc = "médio" 
            @nivel_text_cria_emoc= "média"
            @sol_text_cria_emoc= " "


        elsif @media_cria_emoc >=4 && @media_cria_emoc <= 5

            @nivel_cria_emoc = "alto" 
            @nivel_text_cria_emoc= "alta"
            @sol_text_cria_emoc= " "
    end


      @media = 
      {
        "Consciência Emocional" => [[@media_cons_emoc],@nivel_cons_emoc,@nivel_text_cons_emoc,@sol_text_cons_emoc], 
        "Regulação Emocional" => [[@media_reg_emoc],@nivel_reg_emoc,@nivel_text_reg_emoc,@sol_text_reg_emoc],
        "Consciência Social" => [[@media_cons_soc],@nivel_cons_soc,@nivel_text_cons_soc,@sol_text_cons_soc], 
        "Autocontrole Emocional" => [[@media_aut_emoc],@nivel_aut_emoc,@nivel_text_aut_emoc,@sol_text_aut_emoc],
        "Criatividade Emocional" => [[@media_cria_emoc],@nivel_cria_emoc,@nivel_text_cria_emoc,@sol_text_cria_emoc]
      }
    
    respond_to do |format|
      format.js {}
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="Resultados_socioemocionais.xlsx"'
      }
    end
  end


 def pdf_list
    @result_socio_emotional = ResultSocioEmotional.find(params[:result])
    student = User.find(@result_socio_emotional.user.id) 
  
   if @result_socio_emotional.cons_emoc >=0 && @result_socio_emotional.cons_emoc < 3

            @nivel_text_cons_emoc = "baixa"
            @sol_text_cons_emoc = "desenvolver"

        elsif @result_socio_emotional.cons_emoc >=3 && @result_socio_emotional.cons_emoc < 4

            @nivel_text_cons_emoc = "média"
            @sol_text_cons_emoc = "melhorar"

        elsif @result_socio_emotional.cons_emoc >=4 && @result_socio_emotional.cons_emoc <= 5

            @nivel_text_cons_emoc = "alta"
            @sol_text_cons_emoc = "potencializar"
    end


    if @result_socio_emotional.reg_emoc >=0 && @result_socio_emotional.reg_emoc < 3

            @nivel_text_reg_emoc= "baixa" 
            @sol_text_reg_emoc= "desenvolver" 

        elsif @result_socio_emotional.reg_emoc >=3 && @result_socio_emotional.reg_emoc < 4

            @nivel_text_reg_emoc= "media" 
            @sol_text_reg_emoc= "melhorar"

        elsif @result_socio_emotional.reg_emoc >=4 && @result_socio_emotional.reg_emoc <= 5

            @nivel_text_reg_emoc= "alta" 
            @sol_text_reg_emoc= "potencializar"
    end


    if @result_socio_emotional.cons_soc >=0 && @result_socio_emotional.cons_soc < 3

            @nivel_text_cons_soc= "baixa" 

        elsif @result_socio_emotional.cons_soc >=3 && @result_socio_emotional.cons_soc < 4

            @nivel_text_cons_soc= "média"

        elsif @result_socio_emotional.cons_soc >=4 && @result_socio_emotional.cons_soc <= 5

            @nivel_text_cons_soc= "alta"
    end


    if @result_socio_emotional.aut_emoc >=0 && @result_socio_emotional.aut_emoc < 2.666666667

            @nivel_text_aut_emoc = "baixa"

        elsif @result_socio_emotional.aut_emoc >=2.666666667 && @result_socio_emotional.aut_emoc < 4

            @nivel_text_aut_emoc = "média" 

        elsif @result_socio_emotional.aut_emoc >=4 && @result_socio_emotional.aut_emoc <= 5

            @nivel_text_aut_emoc = "alta"
    end
    if @result_socio_emotional.cria_emoc >=0 && @result_socio_emotional.cria_emoc < 3

            @nivel_text_cria_emoc= "baixa"

        elsif @result_socio_emotional.cria_emoc >=3 && @result_socio_emotional.cria_emoc < 4

            @nivel_text_cria_emoc= "média"


        elsif @result_socio_emotional.cria_emoc >=4 && @result_socio_emotional.cria_emoc <= 5

            @nivel_text_cria_emoc= "alta"
    end

    respond_to do |format|
      format.html
      format.pdf {
          img = "#{Rails.root}/public/bg_folder.jpg"          
          Prawn::Document.generate("competencias_socioemocionais.pdf", :page_size=> "A4",:background => img) do |pdf|        
          pdf.font("Helvetica", :style => :bold)
          pdf.move_down 20
          pdf.text "Inventário de competencias socioemocionais", :color => "006699", :align => :center, :size => 18
          pdf.move_down 20
          pdf.text "#{@result_socio_emotional.user.nome.titleize}", :align => :center, :size => 14
          pdf.move_down 10
          pdf.text "Realizado em: #{@result_socio_emotional.updated_at.strftime("%d/%m/%Y")}", :color => "006699", :align => :center, :size => 10
          pdf.move_down 20
          pdf.table([["<color rgb='FFFFFF'>Consciência Emocional</color>","<color rgb='FFFFFF'>Regulação Emocional</color>","<color rgb='FFFFFF'>Consciência Social</color>","<color rgb='FFFFFF'>Autocontrole Emocional</color>","<color rgb='FFFFFF'>Criatividade Emocional</color>"],["#{@result_socio_emotional.cons_emoc.round(2)}","#{@result_socio_emotional.reg_emoc.round(2)}","#{@result_socio_emotional.cons_soc.round(2)}","#{@result_socio_emotional.aut_emoc.round(2)}","#{@result_socio_emotional.cria_emoc.round(2)}"] ], :position => :center, row_colors: ['006699', 'ffffff','63307a'], cell_style: { size: 12, align: :center, border_color: "006699", :inline_format => true })
          pdf.move_down 20
          
          pdf.text "Consciência Emocional",:color => "63307a", :align => :left, :size => 14
          pdf.move_down 10
          pdf.font("Helvetica")
          pdf.text "Você apresenta uma <b>#{@nivel_text_cons_emoc}</b> capacidade de reconhecer e compreender os sentimentos e as emoções de si próprio e dos outros, além de manter uma atitude compassiva, de confiança mútua. Procure <b>#{@sol_text_cons_emoc}</b> a sua capacidade de agir com empatia nos relacionamentos e na tomada de decisão.", :inline_format => true, :align => :justify, :size => 12
          pdf.move_down 20
          pdf.font("Helvetica", :style => :bold)
          
          pdf.text "Regulação Emocional",:color => "ec1e27", :align => :left, :size => 14
          pdf.move_down 10
          pdf.font("Helvetica")
          pdf.text "Você apresenta uma <b>#{@nivel_text_reg_emoc}</b> capacidade de manejar as emoções de forma adequada para manter um desempenho satisfatório em situações de estresse. Procure <b>#{@sol_text_reg_emoc}</b> a sua capacidade de se adaptar a situações de mudança com flexibilidade e lidar com as situações de pressão. ",:inline_format => true, :align => :justify, :size => 12
          pdf.move_down 20
          pdf.font("Helvetica", :style => :bold)
          
          pdf.text "Consciência Social",:color => "ff9900", :align => :left, :size => 14
          pdf.move_down 10
          pdf.font("Helvetica")
          pdf.text "Você apresenta uma <b>#{@nivel_text_cons_soc}</b> capacidade de cooperar quando trabalha em equipe, assumindo responsabilidades pelas suas ações, agindo com empatia e senso de colaboração ao reconhecer e entender as dificuldades do outro. ",:inline_format => true, :align => :justify, :size => 12
          pdf.move_down 20
          pdf.font("Helvetica", :style => :bold)

          pdf.text "Autocontrole Emocional",:color => "79b120", :align => :left, :size => 14
          pdf.move_down 10
          pdf.font("Helvetica")
          pdf.text "Você apresenta uma <b>#{@nivel_text_aut_emoc}</b> capacidade de manter as próprias emoções sob controle diante de situações estressantes, assumindo uma atitude de respeito quando os comportamentos dos outros são diferentes dos seus. ",:inline_format => true, :align => :justify, :size => 12
        
          pdf.move_down 20
          pdf.font("Helvetica", :style => :bold)
          
          pdf.text "Criatividade Emocional",:color => "006699", :align => :left, :size => 14
          pdf.move_down 10
          pdf.font("Helvetica")
          pdf.text "Você apresenta uma <b>#{@nivel_text_cria_emoc}</b> capacidade de usar as emoções de forma criativa para solucionar problemas, gerenciar conflitos de forma construtiva, criar oportunidades para experimentar emoções positivas e estabelecer parcerias em prol do interesse coletivo e o bem-estar social.",:inline_format => true, :align => :justify, :size => 12
      
          send_data pdf.render, filename: 'competencias_socioemocionais.pdf', type: 'application/pdf', disposition: "inline"
        end

      }
    end
  end



  def list

    if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id], type: 'Student').all
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
      @centers = []
      @campus.each do |campus|
          @centers << Center.where(campu_id: campus.id)
      end
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.ids)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
      @users = @users.first.to_a
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @centers = @campus.centers.all
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
    end

    if params[:center_id] == 'todos' && params[:campu_id] != 'todos'
      @centers = Center.where(campu_id: params[:campu_id]).find_each
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids,  type: 'Student')
      end
      @users = @users.first.to_a


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      if current_user.type == 'Teacher'
        setup_teacher_search
        @users = @students
        @selecao = "todos os meus alunos"
      else
        @users = User.where(course_id: params[:course_id], type: 'Student').find_each
        @users = @users.to_a
        @course = Course.where(id: params[:course_id]).first
        @selecao = @course.nome
      end
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @subject = Subject.find(params[:subject_id])
      if current_user.type == 'Teacher'
        @classrooms = []
        @subject.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.id == current_user.id
              @classrooms << classroom
            end
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @classrooms = @subject.classrooms
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = @subject.nome
    end
#ano
    if params[:ano] != 'todos' && params[:ano] != nil
      @ano = params[:ano]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @subject.classrooms.each do |classroom|
          if classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@subject.nome}, #{@ano}"
    end
#
#semestre
    if params[:semestre] != 'todos' && params[:semestre] != nil
      @semestre = params[:semestre]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano && classroom.semestre == @semestre
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @subject.classrooms.each do |classroom|
          if classroom.semestre == @semestre && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@semestre} semestre, #{@ano}, #{@subject.nome}"
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        if(user.type == 'Student')
          @users << user
        end
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome.titleize
    end
    #eu alterei isso aqui
    @allUsers = false
    if params[:users_id] == 'todos'
      @allUsers = true
    end

    if @users != nil
      @users = @users.uniq
      @result_socio_emotionals = []
      @users.each do |user|
          user.result_socio_emotionals.each do |result_socio_emotional|
            @result_socio_emotionals << result_socio_emotional
          end
      end

      @datas = @result_socio_emotionals.map(&:data_final).uniq
    else
      redirect_to no_users_error_result_socio_emotionals_path, notice: 'Não há usuarios disponiveis para exibir'
    end

  end


  def search
    if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).sort_by{ |subject| subject.nome}
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

  def campu_selection
    @campu = Campu.find(params[:campu])
    @centers = @campu.centers
  end

  def campu2_selection
    @campu = Campu.find(params[:campu])
    @centers = @campu.centers
  end

  def center_selection
    @center = Center.find(params[:center])
    @courses = @center.courses
  end

  def center2_selection
    @center = Center.find(params[:center])
    @courses = @center.courses
  end

  def course_selection
    @course = Course.find(params[:course])
    @subjects = @course.subjects
  end

  def course2_selection
    @course = Course.find(params[:course])
    @subjects = @course.subjects
  end


  def subject_selection
    @subject = Subject.find(params[:subject])
    if current_user.type == 'Teacher'
      @classrooms = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms << classroom
          end
        end
      end 
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms = @subject.classrooms
    end
    @anos = []
    @classrooms.each do |classroom|
        @anos << classroom.ano
    end
    respond_to do |format|
       format.js {  }
    end
  end

    def subject2_selection
    @subject = Subject.find(params[:subject])
    if current_user.type == 'Teacher'
      @classrooms = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms = @subject.classrooms
    end
    @anos = []
    @classrooms.each do |classroom|
        @anos << classroom.ano
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def ano_selection
    @ano = params[:ano]
    @subject = Subject.find(params[:subject])
    @semestres = []
    if current_user.type == 'Teacher'
      @classrooms = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms = @subject.classrooms
    end
    @classrooms.each do |classroom|
      if classroom.ano == @ano
        @semestres << classroom.semestre
      end
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def ano2_selection
    @ano = params[:ano]
    @subject = Subject.find(params[:subject])
    @semestres = []
    if current_user.type == 'Teacher'
      @classrooms = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms = @subject.classrooms
    end
    @classrooms.each do |classroom|
      if classroom.ano == @ano
        @semestres << classroom.semestre
      end
    end

    respond_to do |format|
       format.js {  }
    end
  end

  def semestre_selection
    @semestre = params[:semestre]
    @subject = Subject.find(params[:subject])
    @classrooms = []
    if current_user.type == 'Teacher'
      @classrooms_pre = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms_pre << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms_pre = @subject.classrooms
    end
    @classrooms_pre.each do |classroom|
      if classroom.semestre == @semestre
        @classrooms << classroom
      end
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def semestre2_selection
    @semestre = params[:semestre]
    @subject = Subject.find(params[:subject])
    @classrooms = []
    if current_user.type == 'Teacher'
      @classrooms_pre = []
      @subject.classrooms.each do |classroom|
        classroom.users.each do |user|
          if user.id == current_user.id
            @classrooms_pre << classroom
          end
        end
      end
    elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
      @classrooms_pre = @subject.classrooms
    end
    @classrooms_pre.each do |classroom|
      if classroom.semestre == @semestre
        @classrooms << classroom
      end
    end
    respond_to do |format|
       format.js {  }
    end
  end

  def classroom_selection
    @classroom = Classroom.find(params[:classroom])
    @users = @classroom.users.each {|user| user.nome = user.nome.mb_chars.upcase}
    @users = @users.sort_by {|user| user.nome}
  end

  def classroom2_selection
    @classroom = Classroom.find(params[:classroom])
    @users = @classroom.users.each {|user| user.nome = user.nome.mb_chars.upcase}
    @users = @users.sort_by {|user| user.nome}
  end

  def analytics
     if current_user.type == 'Teacher'
      setup_teacher_search
    elsif current_user.type == 'Coordinator'
      setup_teacher_search
      @subjects = Subject.where(course_id: @course.id).find_each
      @subjects = @subjects.sort_by{ |subject| subject.nome}
    elsif current_user.type == 'Principal'
      setup_principal_search
    end
  end

  def analytic_list

     if params[:institution_id] == 'todos'
      @users = User.where(type: 'Student').find_each
      @selecao = "todos os institutos"
    else
      @users = User.where(institution_id: params[:institution_id], type: 'Student').all
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
    end

    if params[:campu_id] == 'todos' && params[:institution_id] != 'todos'
      @campus = Campu.where(institution_id: params[:institution_id]).find_each
      @institution = Institution.where(id: params[:institution_id]).first
      @selecao = @institution.nome
      @centers = []
      @campus.each do |campus|
          @centers << Center.where(campu_id: campus.id)
      end
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.ids)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
      @users = @users.first.to_a
    elsif params[:institution_id] != 'todos'
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @centers = @campus.centers.all
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids, type: 'Student')
      end
    end

    if params[:center_id] == 'todos' && params[:campu_id] != 'todos'
      @centers = Center.where(campu_id: params[:campu_id]).find_each
      @campus = Campu.where(id: params[:campu_id]).first
      @selecao = @campus.name
      @courses = []
      @centers.each do |center|
          @courses << Course.where(center_id: center.id)
      end
      @users = []
      @courses.each do |course|
          @users << User.where(course_id: course.ids,  type: 'Student')
      end
      @users = @users.first.to_a


    elsif params[:center_id] != 'todos' && params[:center_id] != nil
      @center = Center.where(campu_id: params[:campu_id]).first
      @selecao = @center.name
      @courses = Course.where(center_id: params[:center_id]).find_each
      @users = []
      @courses.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course_id] != 'todos' && params[:center_id] != nil && params[:center_id] != 'todos'
      if current_user.type == 'Teacher'
        setup_teacher_search
        @users = @students
        @selecao = "todos os meus alunos"
      else
        @users = User.where(course_id: params[:course_id], type: 'Student').find_each
        @users = @users.to_a
        @course = Course.where(id: params[:course_id]).first
        @selecao = @course.nome
      end
    end

    if params[:subject_id] != 'todos' && params[:subject_id] != nil
      @subject = Subject.find(params[:subject_id])
      if current_user.type == 'Teacher'
        @classrooms = []
        @subject.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.id == current_user.id
              @classrooms << classroom
            end
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @classrooms = @subject.classrooms
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = @subject.nome
    end
#ano
    if params[:ano] != 'todos' && params[:ano] != nil
      @ano = params[:ano]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @subject.classrooms.each do |classroom|
          if classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@subject.nome}, #{@ano}"
    end
#
#semestre
    if params[:semestre] != 'todos' && params[:semestre] != nil
      @semestre = params[:semestre]
      if current_user.type == 'Teacher'
        @classrooms = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject && classroom.ano == @ano && classroom.semestre == @semestre
            @classrooms << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @subject.classrooms.each do |classroom|
          if classroom.semestre == @semestre && classroom.ano == @ano
            @classrooms << classroom
          end
        end
      end
      @users = []
      @classrooms.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users << user
          end
        end
      end
      @selecao = "#{@semestre} semestre, #{@ano}, #{@subject.nome}"
    end

    if params[:classroom_id] != 'todos' && params[:classroom_id] != nil
      @classroom = Classroom.where(id: params[:classroom_id]).first
      @selecao = "turma " + @classroom.codigo
      @users = []
      @classroom.users.each do |user|
        if(user.type == 'Student')
          @users << user
        end
      end
    end

    if params[:users_id] != 'todos' && params[:users_id] != nil
      @user = User.where(id: params[:users_id]).first
      @users = []
      @users << @user
      @selecao = @users.first.nome
    end

    @allUsers = false

    if params[:users_id] == 'todos'
      @allUsers = true
    end


      if @users != nil
        @users = @users.uniq
      @result_socio_emotionals = []
      @users.each do |user|
          user.result_socio_emotionals.each do |result_socio_emotional|
            @result_socio_emotionals << result_socio_emotional
          end
      end

      @datas = @result_socio_emotionals.map(&:data_final).uniq
    else
      redirect_to no_users_error_result_socio_emotionals_path, notice: 'Não há usuarios disponiveis para exibir'
    end


    #selecao2
    if params[:institution2_id] == 'todos'
      @users2 = User.where(type: 'Student').find_each
      @selecao2 = "todos os institutos"
    else
      @users2 = User.where(institution_id: params[:institution2_id], type: 'Student').all
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
    end

    if params[:campu2_id] == 'todos' && params[:institution2_id] != 'todos'
      @campus2 = Campu.where(institution_id: params[:institution2_id]).find_each
      @institution2 = Institution.where(id: params[:institution2_id]).first
      @selecao2 = @institution2.nome
      @centers2 = []
      @campus2.each do |campus|
          @centers2 << Center.where(campu_id: campus.id)
      end
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.ids)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids, type: 'Student')
      end
      @users2 = @users2.first.to_a
    elsif params[:institution2_id] != 'todos'
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @centers2 = @campus2.centers.all
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids, type: 'Student')
      end
    end

    if params[:center2_id] == 'todos' && params[:campu2_id] != 'todos'
      @centers2 = Center.where(campu_id: params[:campu2_id]).find_each
      @campus2 = Campu.where(id: params[:campu2_id]).first
      @selecao2 = @campus2.name
      @courses2 = []
      @centers2.each do |center|
          @courses2 << Course.where(center_id: center.id)
      end
      @users2 = []
      @courses2.each do |course|
          @users2 << User.where(course_id: course.ids,  type: 'Student')
      end
      @users2 = @users2.first.to_a


    elsif params[:center2_id] != 'todos' && params[:center2_id] != nil
      @center2 = Center.where(campu_id: params[:campu2_id]).first
      @selecao2 = @center2.name
      @courses2 = Course.where(center_id: params[:center2_id]).find_each
      @users2 = []
      @courses2.each do |course|
          course.users.each do |user|
            if(user.type == 'Student')
              @users2 << user
            end
          end
          #@users << User.where(course_id: course.id,  type: 'Student').find_each.to_a
      end
    end

    if params[:course2_id] != 'todos' && params[:center2_id] != nil && params[:center2_id] != 'todos'
      if current_user.type == 'Teacher'
        setup_teacher_search
        @users2 = @students
        @selecao2 = "todos os meus alunos"
      else
        @users2 = User.where(course_id: params[:course2_id], type: 'Student').find_each
        @users2 = @users2.to_a
        @course2 = Course.where(id: params[:course2_id]).first
        @selecao2 = @course2.nome
      end
    end

    if params[:subject2_id] != 'todos' && params[:subject2_id] != nil
      @subject2 = Subject.find(params[:subject2_id])
      if current_user.type == 'Teacher'
        @classrooms2 = []
        @subject2.classrooms.each do |classroom|
          classroom.users.each do |user|
            if user.id == current_user.id
              @classrooms2 << classroom
            end
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @classrooms2 = @subject2.classrooms 
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = @subject2.nome
    end
#ano
    if params[:ano2] != 'todos' && params[:ano2] != nil
      @ano2 = params[:ano2]
      if current_user.type == 'Teacher'
        @classrooms2 = []
        current_user.classrooms.each do |classroom|
          if classroom.subject == @subject2 && classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator'
        @subject2.classrooms.each do |classroom|
          if classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = "#{@subject2.nome}, #{@ano2}"
    end
#
#semestre
    if params[:semestre2] != 'todos' && params[:semestre2] != nil
      @semestre2 = params[:semestre2]
      if current_user.type == 'Teacher'
        @classrooms2 = []
          current_user.classrooms.each do |classroom|
          if classroom.subject == @subject2 && classroom.ano == @ano2 && classroom.semestre == @semestre2
            @classrooms2 << classroom
          end
        end
      elsif current_user.type == 'Coordinator' || current_user.type == 'Principal' || current_user.type == 'Administrator' 
        @subject2.classrooms.each do |classroom|
          if classroom.semestre == @semestre2 && classroom.ano == @ano2
            @classrooms2 << classroom
          end
        end
      end
      @users2 = []
      @classrooms2.each do |classroom|
        classroom.users.each do |user|
          if(user.type == 'Student')
            @users2 << user
          end
        end
      end
      @selecao2 = "#{@semestre2} semestre, #{@ano2}, #{@subject2.nome}"
    end

    if params[:classroom2_id] != 'todos' && params[:classroom2_id] != nil
      @classroom2 = Classroom.where(id: params[:classroom2_id]).first
      @selecao2 = "turma " + @classroom2.codigo
      @users2 = []
      @classroom2.users.each do |user|
        if(user.type == 'Student')
          @users2 << user
        end
      end
    end

    if params[:users2_id] != 'todos' && params[:users2_id] != nil
      @user2 = User.where(id: params[:users2_id]).first
      @users2 = []
      @users2 << @user2
      @selecao2 = @users2.first.nome
    end
    @allUsers2 = false
    if params[:users2_id] == 'todos'
      @allUsers2 = true
    end

      if @users2 != nil
        @users2 = @users2.uniq
      @result_socio_emotionals2 = []
      @users2.each do |user|
          user.result_socio_emotionals.each do |result_socio_emotional|
            @result_socio_emotionals2 << result_socio_emotional
          end
      end

      @datas2 = @result_socio_emotionals2.map(&:data_final).uniq
    else
      redirect_to no_users_error_result_socio_emotionals_path, notice: 'Não há usuarios disponiveis para exibir'
    end

  end



  def compare_by_date
    @selecao = params[:selecao]
    @selecao2 = params[:selecao2]
    @allUsers = params[:allUsers]
    @result_socio_emotionals = []
    if @allUsers == 'false'
        @resultados = params[:result_socio_emotionals]
      @resultados.each do |result_socio_emotional|
        pre = ResultSocioEmotional.where(data_final: params[:data_final], id: result_socio_emotional).first
        if not pre.nil?
          @result_socio_emotionals << pre
        end
      end
    else
        @resultados = params[:users]
        @resultados.each do |i|
            pre = ResultSocioEmotional.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @result_socio_emotionals << pre
            end
        end
    end

 
    @nomeUsuario = []
    @media_cons_emoc = 0.0
    @media_reg_emoc = 0.0
    @media_cons_soc = 0.0
    @media_aut_emoc = 0.0
    @media_cria_emoc = 0.0
     

    @result_socio_emotionals.each do |result_socio_emotional|
      @nomeUsuario = result_socio_emotional.user.nome
      @media_cons_emoc = result_socio_emotional.cons_emoc
      @media_reg_emoc = result_socio_emotional.reg_emoc
      @media_cons_soc = result_socio_emotional.cons_soc
      @media_aut_emoc = result_socio_emotional.aut_emoc
      @media_cria_emoc = result_socio_emotional.cria_emoc
    end

   if @media_cons_emoc >=0 && @media_cons_emoc < 3

            @nivel_cons_emoc = "baixo"
            @nivel_text_cons_emoc = "baixa"
            @sol_text_cons_emoc = "desenvolver"

        elsif @media_cons_emoc >=3 && @media_cons_emoc < 4

            @nivel_cons_emoc = "médio" 
            @nivel_text_cons_emoc = "média"
            @sol_text_cons_emoc = "melhorar"

        elsif @media_cons_emoc >=4 && @media_cons_emoc <= 5

            @nivel_cons_emoc = "alto" 
            @nivel_text_cons_emoc = "alta"
            @sol_text_cons_emoc = "potencializar"
    end


    if @media_reg_emoc >=0 && @media_reg_emoc < 3

            @nivel_reg_emoc= "baixo" 
            @nivel_text_reg_emoc= "baixa" 
            @sol_text_reg_emoc= "desenvolver" 

        elsif @media_reg_emoc >=3 && @media_reg_emoc < 4

            @nivel_reg_emoc = "médio" 
            @nivel_text_reg_emoc= "media" 
            @sol_text_reg_emoc= "melhorar"

        elsif @media_reg_emoc >=4 && @media_reg_emoc <= 5

            @nivel_reg_emoc = "alto" 
            @nivel_text_reg_emoc= "alta" 
            @sol_text_reg_emoc= "potencializar"
    end


    if @media_cons_soc >=0 && @media_cons_soc < 3

            @nivel_cons_soc= "baixo" 
            @nivel_text_cons_soc= "baixa" 
            @sol_text_cons_soc= " " 

        elsif @media_cons_soc >=3 && @media_cons_soc < 4

            @nivel_cons_soc = "médio" 
            @nivel_text_cons_soc= "média"
             @sol_text_cons_soc= " " 

        elsif @media_cons_soc >=4 && @media_cons_soc <= 5

            @nivel_cons_soc = "alto" 
            @nivel_text_cons_soc= "alta"
             @sol_text_cons_soc= " " 
    end


    if @media_aut_emoc >=0 && @media_aut_emoc < 2.666666667

            @nivel_aut_emoc= "baixo"
            @nivel_text_aut_emoc = "baixa"
            @sol_text_aut_emoc = " "

        elsif @media_aut_emoc >=2.666666667 && @media_aut_emoc < 4

            @nivel_aut_emoc = "médio" 
            @nivel_text_aut_emoc = "média" 
            @sol_text_aut_emoc = " "

        elsif @media_aut_emoc >=4 && @media_aut_emoc <= 5

            @nivel_aut_emoc = "alto" 
            @nivel_text_aut_emoc = "alta"
            @sol_text_aut_emoc = " "


    end


    if @media_cria_emoc >=0 && @media_cria_emoc < 3 

            @nivel_cria_emoc= "baixo" 
            @nivel_text_cria_emoc= "baixa"
            @sol_text_cria_emoc= " "

        elsif @media_cria_emoc >=3 && @media_cria_emoc < 4

            @nivel_cria_emoc = "médio" 
            @nivel_text_cria_emoc= "média"
            @sol_text_cria_emoc= " "


        elsif @media_cria_emoc >=4 && @media_cria_emoc <= 5

            @nivel_cria_emoc = "alto" 
            @nivel_text_cria_emoc= "alta"
            @sol_text_cria_emoc= " "
    end

  @media = 
      {
        "Consciência Emocional" => [[@media_cons_emoc],@nivel_cons_emoc,@nivel_text_cons_emoc,@sol_text_cons_emoc], 
        "Regulação Emocional" => [[@media_reg_emoc],@nivel_reg_emoc,@nivel_text_reg_emoc,@sol_text_reg_emoc],
        "Consciência Social" => [[@media_cons_soc],@nivel_cons_soc,@nivel_text_cons_soc,@sol_text_cons_soc], 
        "Autocontrole Emocional" => [[@media_aut_emoc],@nivel_aut_emoc,@nivel_text_aut_emoc,@sol_text_aut_emoc],
        "Criatividade Emocional" => [[@media_cria_emoc],@nivel_cria_emoc,@nivel_text_cria_emoc,@sol_text_cria_emoc]
      }


#seleção 2

    @result_socio_emotionals2 = []
    @allUsers2 = params[:allUsers2]
    if  @allUsers2 == 'false'
      @resultados2 = params[:result_socio_emotionals2]
      @resultados2.each do |result_socio_emotional|
        pre = ResultSocioEmotional.where(data_final: params[:data_final2], id: result_socio_emotional).first
        if not pre.nil?
          @result_socio_emotionals2 << pre
        end
      end
    else
        @resultados2 = params[:users2]
        @resultados2.each do |i|
            pre = ResultSocioEmotional.where(user_id:  i)
            if not pre.blank?
              pre = pre.last
              @result_socio_emotionals2 << pre
            end
        end
    end

    @nomeUsuario = []
    @media_cons_emoc2 = 0.0
    @media_reg_emoc2 = 0.0
    @media_cons_soc2 = 0.0
    @media_aut_emoc2 = 0.0
    @media_cria_emoc2 = 0.0


    @result_socio_emotionals2.each do |result_socio_emotional|
      @nomeUsuario2 = result_socio_emotional.user.nome
      @media_cons_emoc2 = result_socio_emotional.cons_emoc
      @media_reg_emoc2 = result_socio_emotional.reg_emoc
      @media_cons_soc2 = result_socio_emotional.cons_soc
      @media_aut_emoc2 = result_socio_emotional.aut_emoc
      @media_cria_emoc2 = result_socio_emotional.cria_emoc
    end
    
 if @media_cons_emoc2 >=0 && @media_cons_emoc2 < 3

            @nivel_cons_emoc2 = "baixo"
            @nivel_text_cons_emoc2 = "baixa"
            @sol_text_cons_emoc2 = "desenvolver"

        elsif @media_cons_emoc2 >=3 && @media_cons_emoc2 < 4

            @nivel_cons_emoc2 = "médio" 
            @nivel_text_cons_emoc2 = "média"
            @sol_text_cons_emoc2 = "melhorar"

        elsif @media_cons_emoc2 >=4 && @media_cons_emoc2 <= 5

            @nivel_cons_emoc2 = "alto" 
            @nivel_text_cons_emoc2 = "alta"
            @sol_text_cons_emoc2 = "potencializar"
    end


    if @media_reg_emoc2 >=0 && @media_reg_emoc2 < 3

            @nivel_reg_emoc2= "baixo" 
            @nivel_text_reg_emoc2= "baixa" 
            @sol_text_reg_emoc2= "desenvolver" 

        elsif @media_reg_emoc2 >=3 && @media_reg_emoc2 < 4

            @nivel_reg_emoc2 = "médio" 
            @nivel_text_reg_emoc2= "media" 
            @sol_text_reg_emoc2= "melhorar"

        elsif @media_reg_emoc2 >=4 && @media_reg_emoc2 <= 5

            @nivel_reg_emoc2 = "alto" 
            @nivel_text_reg_emoc2= "alta" 
            @sol_text_reg_emoc2= "potencializar"
    end


    if @media_cons_soc2 >=0 && @media_cons_soc2 < 3

            @nivel_cons_soc2= "baixo" 
            @nivel_text_cons_soc2= "baixa" 
            @sol_text_cons_soc2= " " 

        elsif @media_cons_soc2 >=3 && @media_cons_soc2 < 4

            @nivel_cons_soc2 = "médio" 
            @nivel_text_cons_soc2= "média"
             @sol_text_cons_soc2= " " 

        elsif @media_cons_soc2 >=4 && @media_cons_soc2 <= 5

            @nivel_cons_soc2 = "alto" 
            @nivel_text_cons_soc2= "alta"
             @sol_text_cons_soc2= " " 
    end


    if @media_aut_emoc2 >=0 && @media_aut_emoc2 < 2.666666667

            @nivel_aut_emoc2= "baixo"
            @nivel_text_aut_emoc2 = "baixa"
            @sol_text_aut_emoc2 = " "

        elsif @media_aut_emoc2 >=2.666666667 && @media_aut_emoc2 < 4

            @nivel_aut_emoc2 = "médio" 
            @nivel_text_aut_emoc2 = "média" 
            @sol_text_aut_emoc2 = " "

        elsif @media_aut_emoc2 >=4 && @media_aut_emoc2 <= 5

            @nivel_aut_emoc2 = "alto" 
            @nivel_text_aut_emoc2 = "alta"
            @sol_text_aut_emoc = " "


    end


    if @media_cria_emoc2 >=0 && @media_cria_emoc2 < 3

            @nivel_cria_emoc2= "baixo" 
            @nivel_text_cria_emoc2= "baixa"
            @sol_text_cria_emoc2= " "

        elsif @media_cria_emoc2 >=3 && @media_cria_emoc2 < 4

            @nivel_cria_emoc2 = "médio" 
            @nivel_text_cria_emoc2= "média"
            @sol_text_cria_emoc2= " "


        elsif @media_cria_emoc2 >=4 && @media_cria_emoc2 <= 5

            @nivel_cria_emoc2 = "alto" 
            @nivel_text_cria_emoc2= "alta"
            @sol_text_cria_emoc2= " "
    end
          @media2 = 
              {
                "Consciência Emocional" => [[@media_cons_emoc2],@nivel_cons_emoc2,@nivel_text_cons_emoc2,@sol_text_cons_emoc2], 
                "Regulação Emocional" => [[@media_reg_emoc2],@nivel_reg_emoc2,@nivel_text_reg_emoc2,@sol_text_reg_emoc2],
                "Consciência Social" => [[@media_cons_soc2],@nivel_cons_soc2,@nivel_text_cons_soc2,@sol_text_cons_soc2], 
                "Autocontrole Emocional" => [[@media_aut_emoc2],@nivel_aut_emoc2,@nivel_text_aut_emoc2,@sol_text_aut_emoc2],
                "Criatividade Emocional" => [[@media_cria_emoc2],@nivel_cria_emoc2,@nivel_text_cria_emoc2,@sol_text_cria_emoc2]
              }
  end

  
  # GET /result_socio_emotionals/new
  def new
    @result_socio_emotional = ResultSocioEmotional.new
  end

  # GET /result_socio_emotionals/1/edit
  def edit
  end

  # POST /result_socio_emotionals
  # POST /result_socio_emotionals.json
  def create
    @result_socio_emotional = ResultSocioEmotional.new(result_socio_emotional_params)

    respond_to do |format|
      if @result_socio_emotional.save
        format.html { redirect_to @result_socio_emotional, notice: 'Result socio emotional was successfully created.' }
        format.json { render :show, status: :created, location: @result_socio_emotional }
      else
        format.html { render :new }
        format.json { render json: @result_socio_emotional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /result_socio_emotionals/1
  # PATCH/PUT /result_socio_emotionals/1.json
  def update
    respond_to do |format|
      if @result_socio_emotional.update(result_socio_emotional_params)
        format.html { redirect_to @result_socio_emotional, notice: 'Result socio emotional was successfully updated.' }
        format.json { render :show, status: :ok, location: @result_socio_emotional }
      else
        format.html { render :edit }
        format.json { render json: @result_socio_emotional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_socio_emotionals/1
  # DELETE /result_socio_emotionals/1.json
  def destroy
    @result_socio_emotional.destroy
    respond_to do |format|
      format.html { redirect_to result_socio_emotionals_url, notice: 'Result socio emotional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result_socio_emotional
      @result_socio_emotional = ResultSocioEmotional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_socio_emotional_params
      params.require(:result_socio_emotional).permit( :cons_emoc, :reg_emoc, :cons_soc, :aut_emoc, :cria_emoc,:data_final,:user_id, :question_socio_emotional_id, :final_date)
    end
end
