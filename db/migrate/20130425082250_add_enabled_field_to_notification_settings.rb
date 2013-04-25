class AddEnabledFieldToNotificationSettings < ActiveRecord::Migration
  def change
    add_column :notification_settings, :enabled, :boolean
  end
end
