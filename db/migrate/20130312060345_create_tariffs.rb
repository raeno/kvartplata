class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.datetime  'start_date'
      t.datetime  'end_date'
      t.float     'cold_water'
      t.float     'hot_water'
      t.float     'energy'
      t.float     'utilities'
      t.text      'comments'
      t.timestamps
    end
  end
end
