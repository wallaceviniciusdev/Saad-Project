class RemoveUserIdFromQuestionSocioEmotionals < ActiveRecord::Migration
  def change
    remove_column :question_socio_emotionals, :user_id, :integer
  end
end
