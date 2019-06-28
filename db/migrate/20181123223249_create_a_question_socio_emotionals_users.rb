class CreateAQuestionSocioEmotionalsUsers < ActiveRecord::Migration
  def change
    create_table :question_socio_emotionals_users do |t|
        t.references :user, index: true, foreign_key: true
        t.references :quiz, index: true, foreign_key: true
    end
  end
end
