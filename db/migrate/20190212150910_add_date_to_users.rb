class AddDateToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :bday, :date
  	add_column :users, :sex, :string
  	add_column :users, :marital_status, :string
  	add_column :users, :city , :string
  	add_column :users, :state, :string
  end
end
