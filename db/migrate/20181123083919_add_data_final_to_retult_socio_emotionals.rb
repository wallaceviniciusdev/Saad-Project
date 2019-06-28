class AddDataFinalToRetultSocioEmotionals < ActiveRecord::Migration
  def change
    add_column :result_socio_emotionals, :data_final, :date
  end
end
