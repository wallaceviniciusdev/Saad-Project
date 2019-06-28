class AddUserIdAndQuestionSocioEmotionalIdResultSocioEmotionals < ActiveRecord::Migration
  def change
  	add_reference :result_socio_emotionals, :user, index: true, foreign_key: true
  	add_reference :result_socio_emotionals, :question_socio_emotional, index: true, foreign_key: true
  end
end
