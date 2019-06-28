class RemoveUserIdFromResultSocioEmotionals < ActiveRecord::Migration
  def change
    remove_column :result_socio_emotionals, :user_id, :integer
  end
end
