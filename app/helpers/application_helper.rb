module ApplicationHelper

  def resource_name
    :user
  end

  def last_reports
    Report.all(:order => 'date DESC', :limit => 3)
  end

  def current_tariff
    Tariff.last
  end

  def current_apartment
    ApartmentInfo.last
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
