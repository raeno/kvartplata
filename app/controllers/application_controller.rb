class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :last_reports, :current_tariff

  def last_reports
    Report.all(:order => 'date DESC', :limit => 3)
  end

  def current_tariff
    Tariff.last
  end

end
