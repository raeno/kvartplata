class SettingsController < ApplicationController

  def index
    @user = current_user
    ns = @user.notification_settings if @user
    p ns if ns
    respond_to do |format|
      format.html
    end
  end

  def save
    @settings =  current_user.notification_settings

    ns = NotificationSettings.create(params[:notification_settings])

    p ns

    respond_to do |format|
      if @settings.update_attributes(params[:notification_settings])
        format.html { redirect_to settings_path, notice: 'настройки успешно сохранены' }
      end

    end

  end

end
