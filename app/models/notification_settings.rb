class NotificationSettings < ActiveRecord::Base
  attr_accessible :notify_by_email, :notify_by_phone, :enabled, :day, :hour, :minute
  belongs_to :user

  after_save :update_notification_shedule

  after_initialize :set_dafault_day_and_time

  def set_dafault_day_and_time
    self.day = 20
    self.hour = 18
    self.minute = 5
  end


  def update_notification_shedule

  end

end
