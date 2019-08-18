# frozen_string_literal: true

class HeadsController < ApplicationController
  before_action :set_head, only: %i[show edit update destroy]
  # GET /heads
  # GET /heads.json
  def index
    if params[:axis_id].present?
      @heads = Axis.find(params[:axis_id]).heads.order(:hard_name)
    elsif current_staff.admin?
      @heads = Head.all.order(:hard_name).includes(:groups, :kids)
    else
      @heads = current_staff.staffable.heads.order(:hard_name)
    end
  end

  # GET /heads/1
  # GET /heads/1.json
  def show; end

  # GET /heads/new
  def new
    @head = Head.new
    if current_staff.admin?
      @axes = Axis.all
      @groups = Group.all
    else
      @axes = current_staff.staffable.axes
      @groups = current_staff.staffable.groups
    end

  end

  # GET /heads/1/edit
  def edit
    if current_staff.admin?
      @axes = Axis.all
      @groups = Group.all
    else
      @axes = current_staff.staffable.axes
      @groups = current_staff.staffable.groups
    end
  end

  # POST /heads
  # POST /heads.json
  def create
    @head = Head.new(head_params)

    respond_to do |format|
      if @head.save
        format.html { redirect_to @head, notice: 'Head was successfully created.' }
        format.json { render :show, status: :created, location: @head }
      else
        format.html { render :new }
        format.json { render json: @head.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heads/1
  # PATCH/PUT /heads/1.json
  def update
    respond_to do |format|
      if @head.update(head_params)
        format.html { redirect_to @head, notice: 'Head was successfully updated.' }
        format.json { render :show, status: :ok, location: @head }
      else
        format.html { render :edit }
        format.json { render json: @head.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heads/1
  # DELETE /heads/1.json
  def destroy
    @head.destroy
    respond_to do |format|
      format.html { redirect_to heads_url, notice: 'Head was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_head
    @head = Head.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def head_params
    params.require(:head).permit(:name, :axis_id, group_ids: [])
  end
end
