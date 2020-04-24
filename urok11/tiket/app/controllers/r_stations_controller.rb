class RStationsController < ApplicationController
  before_action :set_r_station, only: [:show, :edit, :update, :destroy]

  # GET /r_stations
  # GET /r_stations.json
  def index
    @r_stations = RStation.all
  end

  # GET /r_stations/1
  # GET /r_stations/1.json
  def show
  end

  # GET /r_stations/new
  def new
    @r_station = RStation.new
  end

  # GET /r_stations/1/edit
  def edit
  end

  # POST /r_stations
  # POST /r_stations.json
  def create
    @r_station = RStation.new(r_station_params)

    respond_to do |format|
      if @r_station.save
        format.html { redirect_to @r_station, notice: 'R station was successfully created.' }
        format.json { render :show, status: :created, location: @r_station }
      else
        format.html { render :new }
        format.json { render json: @r_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /r_stations/1
  # PATCH/PUT /r_stations/1.json
  def update
    respond_to do |format|
      if @r_station.update(r_station_params)
        format.html { redirect_to @r_station, notice: 'R station was successfully updated.' }
        format.json { render :show, status: :ok, location: @r_station }
      else
        format.html { render :edit }
        format.json { render json: @r_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /r_stations/1
  # DELETE /r_stations/1.json
  def destroy
    @r_station.destroy
    respond_to do |format|
      format.html { redirect_to r_stations_url, notice: 'R station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_r_station
      @r_station = RStation.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def r_station_params
      params.require(:r_station).permit(:title)
    end
end
