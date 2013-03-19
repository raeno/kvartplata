class CreateApartmentInfos < ActiveRecord::Migration
  def change
    create_table :apartment_infos do |t|
      t.string :owner
      t.integer :number
      t.string :address

      t.timestamps
    end
  end
end
