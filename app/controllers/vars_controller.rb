class VarsController < ApplicationController
  before_action :set_boiler, except: [:datalog]
  before_action :set_var, only: [:show, :edit, :update, :destroy, :datalog]

  # GET /vars
  # GET /vars.json
  def index
    @vars = @boiler.vars.all
  end

  # GET /vars/1
  # GET /vars/1.json
  def show
  end

  # GET /vars/new
  def new
    @var = @boiler.vars.new
  end

  # GET /vars/1/edit
  def edit
  end

  # POST /vars
  # POST /vars.json
  def create
    @var = @boiler.vars.new(var_params)
    @mappings = Mapping.all

    respond_to do |format|
      if @var.save
        @var.create_varset
        format.html { redirect_to [@boiler, @var], notice: 'Var was successfully created.' }
        format.json { render :show, status: :created, location: @var }
      else
        format.html { render :new }
        format.json { render json: @var.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vars/1
  # PATCH/PUT /vars/1.json
  def update
    respond_to do |format|
      if @var.update(var_params)
        @var.update_varset
        format.html { redirect_to [@boiler, @var], notice: 'Var was successfully updated.' }
        format.json { render :show, status: :ok, location: @var }
      else
        format.html { render :edit }
        format.json { render json: @var.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vars/1
  # DELETE /vars/1.json
  def destroy
    @var.destroy_varset
    @var.destroy
    respond_to do |format|
      format.html { redirect_to boiler_vars_url, notice: 'Var was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # GET /vars/1/datalog
  # GET /vars/1/datalog.json
  def datalog
    Rails.logger.debug("!! datalog #{@var.inspect}")
    @var.datalog
    respond_to do |format|
      format.html { render plain: 'OK'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
     def set_boiler
      Rails.logger.debug("!! set_boiler params #{params}")
      @boiler = Boiler.find(params[:boiler_id])
   end

   def set_var
     @var = Var.find_by(name: params[:id])
     @var = Var.find(params[:id]) unless @var
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def var_params
      params.require(:var).permit(:name, {:mapping_ids => []}, :boiler, :last_set_date)
    end
end
