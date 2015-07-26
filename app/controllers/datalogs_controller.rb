class DatalogsController < ApplicationController
  before_action :set_datalog, only: [:show, :edit, :update, :destroy]

  # GET /datalogs
  # GET /datalogs.json
  def index
    @datalogs = Datalog.all
  end

  # GET /datalogs/1
  # GET /datalogs/1.json
  def show
  end

  # GET /datalogs/new
  def new
    @datalog = Datalog.new
  end

  # GET /datalogs/1/edit
  def edit
  end

  # POST /datalogs
  # POST /datalogs.json
  def create
    @datalog = Datalog.new(datalog_params)

    respond_to do |format|
      if @datalog.save
        format.html { redirect_to @datalog, notice: 'Datalog was successfully created.' }
        format.json { render :show, status: :created, location: @datalog }
      else
        format.html { render :new }
        format.json { render json: @datalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datalogs/1
  # PATCH/PUT /datalogs/1.json
  def update
    respond_to do |format|
      if @datalog.update(datalog_params)
        format.html { redirect_to @datalog, notice: 'Datalog was successfully updated.' }
        format.json { render :show, status: :ok, location: @datalog }
      else
        format.html { render :edit }
        format.json { render json: @datalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datalogs/1
  # DELETE /datalogs/1.json
  def destroy
    @datalog.destroy
    respond_to do |format|
      format.html { redirect_to datalogs_url, notice: 'Datalog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datalog
      @datalog = Datalog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datalog_params
      params.require(:datalog).permit(:boiler_id, :values)
    end
end
