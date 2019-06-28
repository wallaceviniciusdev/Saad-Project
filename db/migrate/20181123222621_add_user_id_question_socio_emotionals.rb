class AddUserIdQuestionSocioEmotionals < ActiveRecord::Migration
  def change
  	 add_reference :question_socio_emotionals, :user, index: true, foreign_key: true
  end
end
