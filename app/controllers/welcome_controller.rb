class WelcomeController < ApplicationController

  def index

    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    if Metric.time_to_pay?
      redirect_to new_metric_path
    else
      @report = Report.last
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end
end
