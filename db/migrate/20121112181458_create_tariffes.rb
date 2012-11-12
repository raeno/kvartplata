class CreateTariffes < ActiveRecord::Migration
  def change
    create_table :tariffes do |t|

      t.timestamps
    end
  end
end
