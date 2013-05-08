class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_one :notification_settings, :autosave => true


  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :notification_settings_id

  before_create { self.notification_settings = NotificationSettings.new }

end
