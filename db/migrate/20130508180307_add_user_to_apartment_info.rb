class AddUserToApartmentInfo < ActiveRecord::Migration
  def change
    add_column :apartment_infos, :user_id, :integer
  end
end
