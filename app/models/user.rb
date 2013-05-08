class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_one :notification_settings, :autosave => true
  has_one :apartment_info

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name,
                  :notification_settings_id, :apartment_info_id

  before_create :init_relations

  def init_relations
    self.notification_settings ||= NotificationSettings.new
    self.apartment_info ||= ApartmentInfo.new
  end
end
