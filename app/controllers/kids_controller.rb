# frozen_string_literal: true

class KidsController < ApplicationController
  before_action :set_kid, only: %i[show edit update destroy recover]
  before_action :authenticate_staff!

  # GET /kids
  # GET /kids.json
  def index
    @mifal = current_staff.staffable.mifal unless current_staff.admin?
    if params[:group_id].present?
      @kids = Group.find(params[:group_id]).kids
    elsif params[:bus_id].present?
      @kids = Bus.find(params[:bus_id]).kids
    else
      if current_staff.admin?
        @kids = Kid.all.includes(:group)
      else
        if Group.find_by(hard_name: "סל מחזור #{@mifal.name}")
          @kids = Kid.where(id: KidGroup.where.not(group_id: Group.find_by(hard_name: "סל מחזור #{@mifal.name}").id).where(kid_id: current_staff.staffable.kids.ids).pluck(:kid_id))
        else
          @kids = current_staff.staffable.kids.includes(:group)
        end
      end
    end

    respond_to do |format|
      format.html
      format.json
      format.csv { send_data Kid.all.to_csv, filename: "חניכי המדצופי-#{Date.today}.csv" }
      format.xlsx
    end
  end

def stats
  @mifal = current_staff.staffable.mifal unless current_staff.admin?
  if params[:group_id].present?
    @kids = Group.find(params[:group_id]).kids
  elsif params[:bus_id].present?
    @kids = Bus.find(params[:bus_id]).kids
  else
    if current_staff.admin?
      @kids = Kid.all.includes(:group)
    else
      @kids = current_staff.staffable.kids.where.not(group_id: Group.find_by(hard_name: "סל מחזור #{@mifal.name}").id).includes(:group)
    end
  end
  respond_to do |format|
    format.html
    format.json
    format.xlsx{
			if params[:months]
				@headers = ['שם', @mifal.group_name[:single], 'ינואר', 'פברואר', 'מרץ','אפריל','מאי','יוני','יולי','אוגוסט','ספטמבר','אוקטובר','נובמבר','דצמבר']
				@months = true
				response.headers['Content-Disposition'] = 'attachment; filename="stats_by_months.xlsx"'
			else
				names = @mifal.checks.pluck(:name).uniq
				names.delete("Blank")
				@headers = ['שם', @mifal.group_name[:single], names].flatten
				@check_times = ["",""]
				names.each do |name|
					@check_times.append(@mifal.checks.where(name: name).count)
				end
				response.headers['Content-Disposition'] = 'attachment; filename="stats_by_check.xlsx"'
			end
		}
  end
end

  # GET /kids/1
  # GET /kids/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end

   end

  # GET /kids/new
  def new
    @kid = Kid.new
    @mifal = current_staff.staffable
    @groups = @mifal.groups
  end

  # GET /kids/1/edit
  def edit
    @mifal = @kid.mifal
    @groups = @mifal.groups
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(kid_params)
    @mifal = current_staff.staffable
    @groups = @mifal.groups
    if params[:kid][:taz].blank?
      @kid.taz = Kid.generate_taz
    end
    respond_to do |format|
      if @kid.save
        format.html { redirect_to @kid, notice: 'Kid was successfully created.' }
        format.json { render :show, status: :created, location: @kid }
      else
        format.html { render :new }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kids/1
  # PATCH/PUT /kids/1.json
  def update
    @groups = Group.all
    respond_to do |format|
      if @kid.update(kid_params)
        format.html { redirect_to @kid, notice: 'Kid was successfully updated.' }
        format.json { render :show, status: :ok, location: @kid }
      else
        format.html { render :edit }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @mifal = @kid.mifal
    if current_staff.admin? || @kid.groups.empty? || @kid.groups.include?(Group.find_by(hard_name: "סל מחזור #{@mifal.name}"))
      @kid.destroy
    else
      kid_groups = KidGroup.where(kid_id: @kid.id, group_id: @mifal.groups.ids)
      kid_groups.update_all(status: :unactive, leave_cause: params[:kid][:leave_cause])
      kid_groups.touch_all
      @kid.groups << Group.find_by(hard_name: "סל מחזור #{@mifal.name}")
    end
    respond_to do |format|
      format.html { redirect_to kids_url, notice: 'Kid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recover
    @kid.undelete
    respond_to do |format|
      format.html { redirect_to kids_url, notice: 'Kid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
		puts "****************************************"
		puts "import"
		current_staff.staffable.mifal.imported_kids!
    file = params[:file]
    file_type = file.present? ? file.path.split('.').last.to_s.downcase : ''
    Kid.update_imported_kid(file, current_staff.staffable_id) if file.present? && (file_type == 'xlsx')
    redirect_to kids_path
  end

  def toggle
    @kid = Kid.find(params[:id])
    @kid.status = params[:value]
    @kid.save
    redirect_to @kid
  end

  # def import
  #   Kid.my_import(params[:file])
  #   redirect_to kids_path, notice: "הייבוא עבר בהצלחה!"
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kid
    @kid = Kid.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kid_params
    params.require(:kid).permit(:name, :group_id, :last_name, :sex, :phone, :medical,
                                :meds, :food, :city, :ken, :parent_1, :parent_1_phone, :parent_2, :parent_2_phone, :size, :shabat,
                                :parents, :swim, :exits, :comments, :status, :cause, :taz, :grade, :mifal_id, :leave_cause, :fever)
  end
end
