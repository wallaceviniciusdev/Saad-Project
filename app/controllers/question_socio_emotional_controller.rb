class QuestionSocioEmotionalController < ApplicationController
  def index
    @data_final = params[:data_final]
  end
 
  def answer
    @all = params.select{|key, hash| hash == "on"}.keys
    @extras = []
    @all.each do |e|
        @extras << e.dup
    end
    @extras.each do |x|
        x.slice!(0,5)
    end
    @todas = params.select{|key, hash| hash != "on" && key != "commit" && key != "controller" && key != "action" && key != "utf8" && key != "authenticity_token"}
    @todas.each {|k,v| @todas[k] = v.to_f}
    @todas.each do |key, value|
        @extras.each do |x|
            if key == x
                @todas[key] = value + 2
            end
         end
    end 

    q1a = @todas[:q1a] 
    q1b = @todas[:q1b]
    q1c = @todas[:q1c] 
    q1d = @todas[:q1d]
    q1e = @todas[:q1e]

    q2a = @todas[:q2a]
    q2b = @todas[:q2b]
    q2c = @todas[:q2c]
    q2d = @todas[:q2d]
    q2e = @todas[:q2e]

    q3a = @todas[:q3a]
    q3b = @todas[:q3b]
    q3c = @todas[:q3c]
    q3d = @todas[:q3d]
    q3e = @todas[:q3e]

    q4a = @todas[:q4a]
    q4b = @todas[:q4b]  
    q4c = @todas[:q4c]
    q4e = @todas[:q4e] 

    q5a = @todas[:q5a] 
    q5b = @todas[:q5b]
    q5e = @todas[:q5e]

    q6a = @todas[:q6a]
    q6b = @todas[:q6b]

    q7a = @todas[:q7a]

    @result_socio_emotional = ResultSocioEmotional.new
    @result_socio_emotional.cons_emoc = (q1a + q2a + q3a + q4a + q5a + q6a + q7a) / 7.0
    @result_socio_emotional.reg_emoc = (q1b + q2b + q3b + q4b + q5b + q6b)/ 6.0
    @result_socio_emotional.cons_soc = (q1c + q2c + q3c + q4c)/ 4.0
    @result_socio_emotional.aut_emoc = (q1d + q2d + q3d)/ 3.0
    @result_socio_emotional.cria_emoc = (q1e + q2e + q3e + q4e + q5e)/ 5.0
    @result_socio_emotional.user_id = current_user.id
    @result_socio_emotional.data_final = params[:data_final]
    @result_socio_emotional.save
 
  
    redirect_to admin_index_path
  end

end
