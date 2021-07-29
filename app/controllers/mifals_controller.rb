class MifalsController < ApplicationController
  before_action :set_mifal, only: [:show, :edit, :update, :destroy]

  # GET /mifals
  # GET /mifals.json
  def index
    @mifals = Mifal.all.order('id ASC')

    # upload to drive
  end

  # GET /mifals/1
  # GET /mifals/1.json
  def show
    @mifal = Mifal.find(params[:id])
    @kids = @mifal.kids
    if current_staff.admin?
      @events = Event.all.order('created_at DESC').includes(:staff, :eventable)
    else
      @events = current_staff.staffable.all_events.sort_by {|event| event.created_at}.reverse!
    end
    respond_to do |format|
      format.html
      format.json
      format.xlsx
    end
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
        Staff.create!(name: ('רכזת ה' + @mifal.name), email: (@mifal.name + '@gmail.com'), password: '12341234',
          password_confirmation: '12341234', role: 'vip', username: @mifal.name, staffable_type: 'Mifal',
          staffable_id: @mifal.id)
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
    @mifal.axes.each do |axis|
      axis.destroy
    end
    @mifal.groups.each do |group|
      group.destroy
    end
    @mifal.destroy
    respond_to do |format|
      format.html { redirect_to mifals_url, notice: 'Mifal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def prop
    @mifal = Mifal.find(params[:id])
    BusWorker.perform_async(@mifal.id)
    redirect_to buses_url
  end

  def new_import_file
    @mifal = current_staff.staffable
    respond_to do |format|
      format.xlsx
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mifal
      @mifal = Mifal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, :stage, axis_ids: [])
    end
end
