class SettingsController < ApplicationController

  before_filter :authenticate_user!
  def index
    @user = current_user
    respond_to do |format|
      format.html
    end
  end

  def save
    @settings =  current_user.notification_settings

    respond_to do |format|
      if @settings.update_attributes(params[:notification_settings])
        format.html { redirect_to settings_path, notice: 'настройки успешно сохранены' }
      end
    end
  end

  def save_apartment
    @apartment_info =  current_user.apartment_info

    respond_to do |format|
      if @apartment_info.update_attributes(params[:apartment_info])
        format.html { redirect_to settings_path, notice: 'настройки успешно сохранены' }
      end
    end
  end

end
