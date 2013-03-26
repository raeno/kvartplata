class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :last_reports, :current_tariff, :current_apartment
  before_filter :set_i18n_locale_from_params

  before_filter :authenticate_user!

  def last_reports
    Report.all(:order => 'date DESC', :limit => 3)
  end

  def current_tariff
    Tariff.last
  end

  def current_apartment
    ApartmentInfo.last
  end

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include? params[:locale].to_sym
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def self.default_url_options(options={})
    options.merge ({:locale => I18n.locale })
  end

end
