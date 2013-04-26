class NotificationSettings < ActiveRecord::Base
  attr_accessible :notify_by_email, :notify_by_phone, :enabled, :day, :hour, :minute
  belongs_to :user

  after_save :update_notification_shedule


  def update_notification_shedule

  end

end
