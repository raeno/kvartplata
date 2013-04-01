class ReportsController < ApplicationController

  before_filter :authenticate_user!
  def index
    @reports_by_year = Report.grouped_by_months
  end

  def show
    date = Date.new(params[:year].to_i, params[:month].to_i,1)
    @report = Report.find_last_by_date date

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end

  end
end
