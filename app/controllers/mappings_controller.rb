class MappingsController < ApplicationController
  before_action :set_boiler #, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_mapping, only: [:show, :edit, :update, :destroy]

  # GET /mappings
  # GET /mappings.json
  def index
    @mappings = @boiler.mappings.all
  end

  # GET /mappings/1
  # GET /mappings/1.json
  def show
  end

  # GET /mappings/new
  def new
    @mapping = @boiler.mappings.new
  end

  # GET /mappings/1/edit
  def edit
  end

  # POST /mappings
  # POST /mappings.json
  def create
    @mapping = @boiler.mappings.new(mapping_params)

    respond_to do |format|
      if @mapping.save
        format.html { redirect_to [@boiler, @mapping], notice: 'Mapping was successfully created.' }
        format.json { render :show, status: :created, location: @mapping }
      else
        format.html { render :new }
        format.json { render json: @mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mappings/1
  # PATCH/PUT /mappings/1.json
  def update
    respond_to do |format|
      if @mapping.update(mapping_params)
        format.html { redirect_to [@boiler, @mapping], notice: 'Mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @mapping }
      else
        format.html { render :edit }
        format.json { render json: @mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mappings/1
  # DELETE /mappings/1.json
  def destroy
    @mapping.destroy
    respond_to do |format|
      format.html { redirect_to boiler_mappings_url, notice: 'Mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   def set_boiler
      Rails.logger.debug("!! set_boiler params #{params}")
      @boiler = Boiler.find(params[:boiler_id])
   end

   def set_mapping
      Rails.logger.debug("!! set_mapping params #{params}")
      @boiler = Boiler.find(params[:boiler_id])
      @mapping = Mapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mapping_params
      params.require(:mapping).permit(:path, :uri, :datatype)
    end
end
