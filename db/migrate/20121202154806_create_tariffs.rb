class CreateTariffs < ActiveRecord::Migration
  def up
    create_table :tariffs do |t|
      t.integer :id
      t.float :cold_water
      t.float :hot_water
      t.float :energy
      t.datetime :start_date
      t.datetime :end_date
      t.text :comments
      t.timestamps
    end
  end

  def down
    drop_table :tariffs
  end
end
