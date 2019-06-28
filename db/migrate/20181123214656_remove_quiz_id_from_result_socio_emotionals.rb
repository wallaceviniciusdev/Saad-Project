class RemoveQuizIdFromResultSocioEmotionals < ActiveRecord::Migration
  def change
    remove_column :result_socio_emotionals, :question_socio_emotional_id, :integer
  end
end
