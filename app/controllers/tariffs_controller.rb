class TariffsController < ApplicationController
  # GET /tariffs
  # GET /tariffs.json
  def index
    @tariffs = Tariff.all(:order => 'start_date DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tariffs }
    end
  end

  # GET /tariffs/1
  # GET /tariffs/1.json
  def show
    @tariff = Tariff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tariff }
    end
  end

  # GET /tariffs/new
  # GET /tariffs/new.json
  def new
    @tariff = Tariff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tariff }
    end
  end

  # GET /tariffs/1/edit
  def edit
    @tariff = Tariff.find(params[:id])
  end

  # POST /tariffs
  # POST /tariffs.json
  def create
    @tariff = Tariff.new(params[:tariff])

    respond_to do |format|
      if @tariff.save
        format.html { redirect_to @tariff, notice: 'Tariff was successfully created.' }
        format.json { render json: @tariff, status: :created, location: @tariff }
      else
        format.html { render action: "new" }
        format.json { render json: @tariff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tariffs/1
  # PUT /tariffs/1.json
  def update
    @tariff = Tariff.find(params[:id])

    respond_to do |format|
      if @tariff.update_attributes(params[:tariff])
        format.html { redirect_to @tariff, notice: 'Tariff was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tariff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tariffs/1
  # DELETE /tariffs/1.json
  def destroy
    @tariff = Tariff.find(params[:id])
    @tariff.destroy

    respond_to do |format|
      format.html { redirect_to tariffs_url }
      format.json { head :no_content }
    end
  end
end
