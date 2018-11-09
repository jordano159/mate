# frozen_string_literal: true

class ChecksController < ApplicationController
  before_action :set_check, only: %i[show edit update destroy]

  # GET /checks
  # GET /checks.json
  def index
    @checks = if params[:search]
                Check.search(params[:search]).order('created_at DESC')
              elsif params[:buses]
                Check.where.not(bus_id: [nil, ""]).order('created_at DESC')
              elsif params[:show_all] && !current_staff.admin? && !current_staff.vip?
                current_staff.staffable.checks.where(bus_id: [nil, ""]).order('created_at DESC')
              elsif current_staff.admin?
                Check.all.where(bus_id: [nil, ""]).order('created_at DESC')
              else
                current_staff.staffable.checks.where(bus_id: [nil, ""]).where("checks.updated_at >= ?", 1.day.ago).order('created_at DESC')
              end

    respond_to do |format|
      format.html
    end
  end

  # GET /checks/1
  # GET /checks/1.json
  def show; end

  # GET /checks/new
  def new
    if params[:bus]
      @check = Check.new
      @bus = Bus.find(params[:bus])
      @kids = @bus.kids
      @check.bus_id = @bus.id
      @check.kids << @kids
      @check.save(validate: false)
    else
      @check = Check.new
      @group = Group.find(current_staff.staffable_id)
      @kids = @group.kids
      @check.kids << @kids
      @check.save(validate: false)
    end
  end

  # GET /checks/1/edit
  def edit
    if @check.bus_id.blank?
      @group = @check.group if @group
      @kids = @group.kids
    elsif @check.group_id.blank?
      @bus = Bus.find(@check.bus_id)
      @kids = @bus.kids
    end
  end

  # POST /checks
  # POST /checks.json
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
    params.require(:check).permit(:name, :group_id, :approved, attendances_attributes: %i[status id cause], kid_ids: [])
  end
end
