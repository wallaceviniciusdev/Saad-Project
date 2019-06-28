class CreateQuestionSocioEmotionals < ActiveRecord::Migration
  def change
    create_table :question_socio_emotionals do |t|
      t.integer :user_id
      t.date :data_final
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
