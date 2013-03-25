class ReportsController < ApplicationController
  def index
    @reports_by_year = Report.grouped_by_months
  end

  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end

  end
end
