class WelcomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    if Metric.time_to_pay? || !Report.last
      redirect_to new_metric_path
    else
      @report = Report.last
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end
end
