class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|

      t.timestamps
    end
  end
end
