class CreateResultSocioEmotionals < ActiveRecord::Migration
  def change
    create_table :result_socio_emotionals do |t|
      t.float :cons_emoc
      t.float :reg_emoc
      t.float :cons_soc
      t.float :aut_emoc
      t.float :cria_emoc
      t.integer :question_socio_emotional_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
