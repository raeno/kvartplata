class ChangeDatetimeColumnToSeparateDayHourMinuteColumnsForNotificationSettings < ActiveRecord::Migration
  def up
    remove_column :notification_settings, :notification_datetime
    add_column :notification_settings, :day, :integer
    add_column :notification_settings, :hour, :integer
    add_column :notification_settings, :minute, :integer
  end

  def down
    add_column :notification_settings, :notification_datetime, :datetime
    remove_column :notification_settings, :day
    remove_column :notification_settings, :hour
    remove_column :notification_settings, :minute
  end
end
