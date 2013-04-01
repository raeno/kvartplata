class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_i18n_locale_from_params

  layout :layout

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

  private

  def layout
    !user_signed_in? || devise_controller? ? 'devise' : 'application'
  end

end
