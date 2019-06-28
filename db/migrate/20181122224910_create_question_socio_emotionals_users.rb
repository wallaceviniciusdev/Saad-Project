class CreateQuestionSocioEmotionalsUsers < ActiveRecord::Migration
  def change
    create_table :question_socio_emotionals_users do |t|
    	t.references :user, index: {:name =>"index_emotional_users"}, foreign_key: true
        t.references :question_socio_emotional, index: {:name => "index_emotional_question"}, foreign_key: true
    end
  end
end
