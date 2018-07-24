class ChecksController < ApplicationController
  before_action :set_check, only: [:show, :edit, :update, :destroy]


  # GET /checks
  # GET /checks.json
  def index
    if params[:search]
      @checks = Check.search(params[:search]).order("created_at DESC")
    else
      if @level == 1
        @checks = Check.where("group_id = ? AND created_at > ?", current_staff.staffable.id, 1.day.ago).order("created_at DESC")
        # @checks = current_staff.staffable.checks.order("created_at DESC")
      elsif @level == 2
        @checks = Check.where("created_at > ?", 1.day.ago).where(group_id: current_staff.staffable.groups.map(&:id)).order("created_at DESC")
      else
        @checks = Check.all.where("created_at > ?", 1.day.ago).order("created_at DESC")
      end
    end

    respond_to do |format|
      format.html
    end
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
      @kids = @check.my_group.kids
  end

  # POST /checks
  # POST /checks.json
  def create
    @check = Check.new(check_params)
    respond_to do |format|
      if @check.save
        @kids = current_staff.staffable.kids
        @check.kids << @kids
        format.html { redirect_to edit_check_path(@check), notice: 'Check was successfully created.' }
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
      params.require(:check).permit(:name, :group_id, :approved, attendances_attributes: [:status, :id, :cause], kid_ids: [])
    end
end
