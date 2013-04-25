class NotificationSettings < ActiveRecord::Base
  attr_accessible :notification_datetime, :notify_by_email, :notify_by_phone
  belongs_to :user
end