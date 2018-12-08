class MifalsController < ApplicationController
  before_action :set_mifal, only: [:show, :edit, :update, :destroy]

  # GET /mifals
  # GET /mifals.json
  def index
    @mifals = Mifal.all.order('id ASC')
  end

  # GET /mifals/1
  # GET /mifals/1.json
  def show
  end

  # GET /mifals/new
  def new
    @mifal = Mifal.new
  end

  # GET /mifals/1/edit
  def edit
  end

  # POST /mifals
  # POST /mifals.json
  def create
    @mifal = Mifal.new(mifal_params)

    respond_to do |format|
      if @mifal.save
        format.html { redirect_to @mifal, notice: 'Mifal was successfully created.' }
        format.json { render :show, status: :created, location: @mifal }
      else
        format.html { render :new }
        format.json { render json: @mifal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mifals/1
  # PATCH/PUT /mifals/1.json
  def update
    respond_to do |format|
      if @mifal.update(mifal_params)
        format.html { redirect_to @mifal, notice: 'Mifal was successfully updated.' }
        format.json { render :show, status: :ok, location: @mifal }
      else
        format.html { render :edit }
        format.json { render json: @mifal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mifals/1
  # DELETE /mifals/1.json
  def destroy
    @mifal.destroy
    respond_to do |format|
      format.html { redirect_to mifals_url, notice: 'Mifal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mifal
      @mifal = Mifal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, axis_ids: [])
    end
end
