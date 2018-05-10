class AxesController < ApplicationController
  before_action :set_axis, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_staff!

  # GET /axes
  # GET /axes.json
  def index
    @axes = Axis.all
  end

  # GET /axes/1
  # GET /axes/1.json
  def show
  end

  # GET /axes/new
  def new
    @axis = Axis.new
  end

  # GET /axes/1/edit
  def edit
  end

  # POST /axes
  # POST /axes.json
  def create
    @axis = Axis.new(axis_params)

    respond_to do |format|
      if @axis.save
        format.html { redirect_to @axis, notice: 'Axis was successfully created.' }
        format.json { render :show, status: :created, location: @axis }
      else
        format.html { render :new }
        format.json { render json: @axis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /axes/1
  # PATCH/PUT /axes/1.json
  def update
    respond_to do |format|
      if @axis.update(axis_params)
        format.html { redirect_to @axis, notice: 'Axis was successfully updated.' }
        format.json { render :show, status: :ok, location: @axis }
      else
        format.html { render :edit }
        format.json { render json: @axis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /axes/1
  # DELETE /axes/1.json
  def destroy
    @axis.destroy
    respond_to do |format|
      format.html { redirect_to axes_url, notice: 'Axis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_axis
      @axis = Axis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def axis_params
      params.require(:axis).permit(:name)
    end
end
