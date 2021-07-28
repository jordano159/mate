class ChecksController < ApplicationController
  before_action :set_check, only: %i[show edit update destroy]

  def index
    if params[:delete_in_progress]
      current_staff.staffable.delete_in_progress
    end
    if params[:search].present?
      @checks = Check.search(params[:search]).order('created_at DESC')
    elsif params[:buses].present?
      @checks = Check.where.not(bus_id: nil).order('created_at DESC')
    elsif params[:show_all].present? && !current_staff.admin? && !current_staff.vip?
      @checks = Check.where(bus_id: nil).order('created_at DESC')
    elsif current_staff.admin?
      @checks = Check.where(bus_id: nil).order('created_at DESC')
    else
      @checks = current_staff.staffable.checks.where(bus_id: nil).order('created_at DESC')
    end

    respond_to do |format|
      format.html
    end
  end

  def show; end

  def new
    if params[:bus]
      @check = Check.new
      @bus = Bus.find(params[:bus])
      @kids = @bus.kids.order(name: :desc, ken: :asc)
      @check.name = "נוכחות אוטובוס #{@bus.name}"
      @check.bus_id = @bus.id
      @mifal = @check.bus.mifal
      @check.kids << @kids
      @check.approved = true
      @check.save(validate: false)
    else
      @check = Check.new # יוצר נוכחות חדשה וריקה
      @group = Group.find(params[:g_id]) # מצהיר על הקבוצה של הנוכחות
      @check.group_id = @group.id
      @mifal = @check.group.mifal
      @check.name = "נוכחות חדשה"
      @kids = @group.kids.order(name: :desc, ken: :asc) # set kids
      @check.kids << @kids # assoicate kids to check
      unless @group.mifal.has_approve
        @check.approved = true
      end
      @check.save(validate: false)
    end
  end

  def edit
    if @check.bus_id.blank?
      @group = @check.group
      @mifal = @check.group.mifal
      @kids = @group.kids.order(name: :desc, ken: :asc)
    elsif @check.group_id.blank?
      @bus = Bus.find(@check.bus_id)
      @check.bus_id = @bus.id
      @mifal = @check.bus.mifal
      @kids = @bus.kids.order(name: :desc, ken: :asc)
    end
  end

  def create
    @check = Check.new(check_params)
    respond_to do |format|
      if @check.save
        format.html { redirect_to check_path(@check), notice: 'Check was successfully created.' }
        format.json { render :show, status: :created, location: @check }
      else
        format.html { render :new }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # @check.kids.count.times do |index|
      #   check_params[:attendances_attributes][index.to_s]["fever"] = check_params[:attendances_attributes][index.to_s]["fever"].to_i
      #   puts check_params[:attendances_attributes][index.to_s]["fever"].is_a? Integer
      # end
      # puts "****************************************"
      # puts check_params[:attendances_attributes]
      if @check.update(check_params)
        @check.delete_blank_checks
        format.html { redirect_to @check, notice: 'Check was successfully updated.' }
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @check.destroy
    respond_to do |format|
      format.html { redirect_to checks_url, notice: 'Check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def set_check
    @check = Check.find(params[:id])
  end


  def check_params
    params.require(:check).permit(:name, :group_id, :approved, :date, attendances_attributes: %i[status id cause fever], kid_ids: [])
  end
end
