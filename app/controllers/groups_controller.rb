# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups
  # GET /groups.json
  def index
    if params[:head_id].present?
      @groups = Head.find(params[:head_id]).groups.order('id ASC')
    elsif current_staff.admin?
      @groups = Group.all.order('id ASC').includes(:kids)
    else
      @groups = current_staff.staffable.groups.where.not(name: "סל מחזור #{current_staff.staffable.mifal.name}").order('id ASC')
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show; end

  # GET /groups/new
  def new
    @group = Group.new
    @heads = Head.all
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    @mifal = @group.mifal
    @heads = @mifal.heads
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @heads = Head.all

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @heads = Head.all
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :head_id, kid_ids: [])
  end
end
