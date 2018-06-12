class ChecksController < ApplicationController
  before_action :set_check, only: [:show, :edit, :update, :destroy]

  # GET /checks
  # GET /checks.json
  def index
    if @level < 2
      @checks = []
      Attendance.all.each do |c|
        if Kid.find(c.kid_id).group.id == current_staff.staffable.id
          if !@checks.include? c.check
            @checks << c.check
          end
        end
      end
    else
      @checks = Check.all
  end
    # @checks = Check.includes(:attendances).where(attendances: { Kid.find(attendances.first.kid_id).group.id = current_staff.staffable.id }
  end

  # GET /checks/1
  # GET /checks/1.json
  def show
  end

  # GET /checks/new
  def new
    @check = Check.new
  end

  # GET /checks/1/edit
  def edit
    @kids = current_staff.staffable.kids
  end

  # POST /checks
  # POST /checks.json
  def create
    @check = Check.new(check_params)
    @kids = current_staff.staffable.kids
    @check.kids << @kids

    respond_to do |format|
      if @check.save
        format.html { redirect_to @check, notice: 'Check was successfully created.' }
        format.json { render :show, status: :created, location: @check }
      else
        format.html { render :new }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checks/1
  # PATCH/PUT /checks/1.json
  def update
    respond_to do |format|
      if @check.update(check_params)
        format.html { redirect_to @check, notice: 'Check was successfully updated.' }
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checks/1
  # DELETE /checks/1.json
  def destroy
    @check.destroy
    respond_to do |format|
      format.html { redirect_to checks_url, notice: 'Check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check
      @check = Check.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def check_params
      params.require(:check).permit(:name, attendances_attributes: [:status, :id, :cause], kid_ids: [])
    end
end
