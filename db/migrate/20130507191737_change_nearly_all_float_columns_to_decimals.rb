class ChangeNearlyAllFloatColumnsToDecimals < ActiveRecord::Migration
  def up
    change_column :metrics, :cold_counter_kitchen, :decimal, :scale => 2, :precision => 16
    change_column :metrics, :hot_counter_kitchen, :decimal, :scale => 2, :precision => 16
    change_column :metrics, :cold_counter_bathroom, :decimal, :scale => 2, :precision => 16
    change_column :metrics, :hot_counter_bathroom, :decimal, :scale => 2, :precision => 16
    change_column :metrics, :energy_counter, :decimal, :scale => 2, :precision => 16

    change_column :tariffs, :cold_water, :decimal, :scale => 2, :precision => 16
    change_column :tariffs, :hot_water, :decimal, :scale => 2, :precision => 16
    change_column :tariffs, :utilities, :decimal, :scale => 2, :precision => 16
    change_column :tariffs, :energy, :decimal, :scale => 2, :precision => 16

    change_column :reports, :cold_water, :decimal, :scale => 2, :precision => 16
    change_column :reports, :hot_water, :decimal, :scale => 2, :precision => 16
    change_column :reports, :energy, :decimal, :scale => 2, :precision => 16
    change_column :reports, :utilities, :decimal, :scale => 2, :precision => 16
    change_column :reports, :total, :decimal, :scale => 2, :precision => 16
  end

  def down
    change_column :metrics, :cold_counter_kitchen, :float
    change_column :metrics, :hot_counter_kitchen, :float
    change_column :metrics, :cold_counter_bathroom, :float
    change_column :metrics, :hot_counter_bathroom, :float
    change_column :metrics, :energy_counter, :float

    change_column :tariffs, :cold_water, :float
    change_column :tariffs, :hot_water, :float
    change_column :tariffs, :utilities, :float
    change_column :tariffs, :energy, :float
    change_column :tariffs, :total, :float

    change_column :reports, :cold_water, :float
    change_column :reports, :hot_water, :float
    change_column :reports, :energy, :float
    change_column :reports, :utilities, :float
  end
end
