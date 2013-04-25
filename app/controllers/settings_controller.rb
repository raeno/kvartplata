class SettingsController < ApplicationController

  def index
    @user = current_user
    ns = @user.notification_settings if @user
    p ns if ns
    respond_to do |format|
      format.html
    end
  end

end
