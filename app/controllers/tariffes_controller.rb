class TariffesController < ApplicationController
  # GET /tariffes
  # GET /tariffes.json
  def index
    @tariffes = Tariff.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tariffes }
    end
  end

  # GET /tariffes/1
  # GET /tariffes/1.json
  def show
    @tariffe = Tariff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tariffe }
    end
  end

  # GET /tariffes/new
  # GET /tariffes/new.json
  def new
    @tariffe = Tariff.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tariffe }
    end
  end

  # GET /tariffes/1/edit
  def edit
    @tariffe = Tariff.find(params[:id])
  end

  # POST /tariffes
  # POST /tariffes.json
  def create
    @tariffe = Tariff.new(params[:tariffe])

    respond_to do |format|
      if @tariffe.save
        format.html { redirect_to @tariffe, notice: 'Tariffe was successfully created.' }
        format.json { render json: @tariffe, status: :created, location: @tariffe }
      else
        format.html { render action: "new" }
        format.json { render json: @tariffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tariffes/1
  # PUT /tariffes/1.json
  def update
    @tariffe = Tariff.find(params[:id])

    respond_to do |format|
      if @tariffe.update_attributes(params[:tariffe])
        format.html { redirect_to @tariffe, notice: 'Tariffe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tariffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tariffes/1
  # DELETE /tariffes/1.json
  def destroy
    @tariffe = Tariff.find(params[:id])
    @tariffe.destroy

    respond_to do |format|
      format.html { redirect_to tariffes_url }
      format.json { head :no_content }
    end
  end
end
