class MetricsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @metrics = Metric.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @metrics }
    end
  end


  def new
    @metric = Metric.new
    @metric.month = DateTime.now

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @metric }
    end
  end

  def edit
    @metric = Metric.find(params[:id])
  end

  # POST /metrics
  # POST /metrics.json
  def create
    @metric = Metric.new(params[:metric])

    respond_to do |format|
      if @metric.save
        format.html { @metric.report ? redirect_to(@metric.report.month_year_path) : redirect_to(new_metric_path) }
        format.json { render json: @metric, status: :created, location: @metric }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /metrics/1
  # PUT /metrics/1.json
  def update
    @metric = Metric.find(params[:id])

    respond_to do |format|
      if @metric.update_attributes(params[:metric])
        format.html { redirect_to @metric, notice: 'Metric was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metrics/1
  # DELETE /metrics/1.json
  def destroy
    @metric = Metric.find(params[:id])
    @metric.destroy

    respond_to do |format|
      format.html { redirect_to metrics_url }
      format.json { head :no_content }
    end
  end
end
