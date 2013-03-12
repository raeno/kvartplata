class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :date
      t.float :cold_water
      t.float :hot_water
      t.float :utilities
      t.float :energy
      t.float :total

      t.references :current_metric
      t.references :previous_metric

      t.references  :tariff

      t.timestamps
    end
  end
end
