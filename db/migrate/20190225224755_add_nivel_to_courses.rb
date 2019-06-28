class AddNivelToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :nivel, :string
  end
end
