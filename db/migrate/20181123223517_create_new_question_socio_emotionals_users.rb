class CreateNewQuestionSocioEmotionalsUsers < ActiveRecord::Migration
  def change
    create_table :question_socio_emotionals_users do |t|
        t.references :user, index: true, foreign_key: true
        t.references :question_socio_emotional, index: {:name => "index_question_users_on_question_id"}, foreign_key: true
    end
  end
end
