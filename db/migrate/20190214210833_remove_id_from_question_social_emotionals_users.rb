class RemoveIdFromQuestionSocialEmotionalsUsers < ActiveRecord::Migration
  def change
  	remove_column :question_socio_emotionals_users, :id
  end
end
