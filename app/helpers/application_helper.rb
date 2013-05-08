module ApplicationHelper

  def resource_name
    :user
  end

  def last_reports
    @last_reports ||= Report.all(:order => 'date DESC', :limit => 3)
  end

  def current_apartment
    current_user.apartment_info
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
