class AddApartmentInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :apartment_info_id, :integer
  end
end
