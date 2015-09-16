class BoilersController < ApplicationController
  before_action :set_boiler, only: [:show, :edit, :update, :destroy]

  # GET /boilers
  # GET /boilers.json
  def index
    @boilers = Boiler.all
  end

  # GET /boilers/1
  # GET /boilers/1.json
  def show
    @start_date = 25.hour.ago.utc
    @datalogs = @boiler.datalogs.where('created_at > ?', @start_date)
    boiler_state_colors = {
      'Ready' => 'blue', 'Ignition' => 'orange', 'Preheat' => 'yellow', 'Heating' => 'green',
      'Ember burnout' => 'pink', 'Switched off' => '#ddd', 'De-ash' => 'purple'
    }
    boiler_state_colors.default = 'black'
    @series = Hash.new
    @series[:boiler_bottom_temp] = @datalogs.map do |d|
      dataset = JSON.parse(d.dataset)
      {
        x: d.created_at.to_time.to_i * 1000,
        y: dataset['Boiler/Boiler/Boiler bottom'].to_i
      }
    end
    @series[:boiler_flue_gas_temp] = @datalogs.map do |d|
      dataset = JSON.parse(d.dataset)
      {
        x: d.created_at.to_time.to_i * 1000,
        y: dataset['Boiler/Boiler/Flue gas'].to_i
      }
    end
    @series[:buffer_charge] = @datalogs.map do |d|
      dataset = JSON.parse(d.dataset)
      point_data = {
        x: d.created_at.to_time.to_i * 1000,
        y: dataset['Buffer/Buffer/demanded output/Charging Status'].to_i,
        color: Boiler.color_for_boiler_state(dataset['Boiler/Boiler']),
        bs: dataset['Boiler/Boiler']
      }
      outline_color = nil
      if dataset['Buffer/Buffer'] == 'Heat dissipation'
        outline_color = 'red'
      elsif dataset['Buffer/Buffer'] == 'ResidHeat'
        outline_color = 'lime'
      end
      if outline_color
        point_data[:marker] = {lineColor: outline_color, lineWidth: 1}
      end
      point_data
    end
    @series[:buffer_top_temp] = @datalogs.map do |d|
      dataset = JSON.parse(d.dataset)
      {
        x: d.created_at.to_time.to_i * 1000,
        y: dataset['Buffer/Buffer/Buffer top'].to_i
      }
    end
    @series[:buffer_bottom_temp] = @datalogs.map do |d|
      dataset = JSON.parse(d.dataset)
      {
        x: d.created_at.to_time.to_i * 1000,
        y: dataset['Buffer/Buffer/Buffer bottom'].to_i
      }
    end
  end

  # GET /boilers/new
  def new
    @boiler = Boiler.new
  end

  # GET /boilers/1/edit
  def edit
  end

  # POST /boilers
  # POST /boilers.json
  def create
    @boiler = Boiler.new(boiler_params)

    respond_to do |format|
      if @boiler.save
        format.html { redirect_to @boiler, notice: 'Boiler was successfully created.' }
        format.json { render :show, status: :created, location: @boiler }
      else
        format.html { render :new }
        format.json { render json: @boiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boilers/1
  # PATCH/PUT /boilers/1.json
  def update
    respond_to do |format|
      if @boiler.update(boiler_params)
        format.html { redirect_to @boiler, notice: 'Boiler was successfully updated.' }
        format.json { render :show, status: :ok, location: @boiler }
      else
        format.html { render :edit }
        format.json { render json: @boiler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boilers/1
  # DELETE /boilers/1.json
  def destroy
    @boiler.destroy
    respond_to do |format|
      format.html { redirect_to boilers_url, notice: 'Boiler was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boiler
      @boiler = Boiler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boiler_params
      params[:boiler]
    end
end
