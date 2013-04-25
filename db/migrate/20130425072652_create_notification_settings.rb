class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.boolean :notify_by_email
      t.boolean :notify_by_phone
      t.datetime :notification_datetime

      t.references :user

      t.timestamps
    end
  end
end
