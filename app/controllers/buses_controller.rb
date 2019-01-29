class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :edit, :update, :destroy]

  # GET /buses
  # GET /buses.json
  def index
    if current_staff.admin?
      @buses = Bus.all.order('id ASC')
    else
      @buses = current_staff.staffable.buses
    end
  end

  # GET /buses/1
  # GET /buses/1.json
  def show
  end

  # GET /buses/new
  def new
    @bus = Bus.new
    @mifal = current_staff.staffable
  end

  # GET /buses/1/edit
  def edit
    @mifal = current_staff.staffable
  end

  # POST /buses
  # POST /buses.json
  def create
    @bus = Bus.new(bus_params)
    @bus.mifal_id = current_staff.staffable.id

    respond_to do |format|
      if @bus.save
        populate_bus(params[:bus][:city]) if params[:bus][:city]
        format.html { redirect_to @bus, notice: 'Bus was successfully created.' }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buses/1
  # PATCH/PUT /buses/1.json
  def update
    respond_to do |format|
      if @bus.update(bus_params)
        if params[:bus].present? && params[:bus][:city].present?
          populate_bus(params[:bus][:city])
        end
        format.html { redirect_to @bus, notice: 'Bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1
  # DELETE /buses/1.json
  def destroy
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to buses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def populate_bus(cities)
      cities.each do |c|
        Kid.where("city = ?", c).each do |k|
          k.bus_id = @bus.id
          k.save
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_params
      params.require(:bus).permit(:name, :mifal_id, :city, kid_ids: [])
    end
end
