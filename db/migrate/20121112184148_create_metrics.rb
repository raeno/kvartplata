class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.float :cold_counter_kitchen
      t.float :hot_counter_kitchen
      t.float :cold_counter_bathroom
      t.float :hot_counter_bathroom
      t.float :energy_counter
      t.datetime :month
      t.timestamps
    end
  end
end
