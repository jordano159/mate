class StaffsController < ApplicationController
  before_action :load_staffable
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  def index
    @staffs = @staffable.staffs
  end

  def show
  end

  def new
    @staff = Staff.new
  end

  def edit
    redirect_to '/' if !current_staff.admin?
  end

  def create
  @staff = @staffable.staffs.new(staff_params)
  if @staff.save
    redirect_to [@staffable, :staffs], notice: 'Staff created'
  else
    render :new
  end
end

# PATCH/PUT /staffs/1
# PATCH/PUT /staffs/1.json
def update
  respond_to do |format|
    if @staff.update(staff_params)
      format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
      format.json { render :show, status: :ok, location: @staff }
    else
      format.html { render :edit }
      format.json { render json: @staff.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /staffs/1
# DELETE /staffs/1.json
def destroy
  @staff.destroy
  respond_to do |format|
    format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
    format.json { head :no_content }
  end
end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def load_staffable
    resource, id = request.path.split('/')[1,2]
    @staffable = resource.singularize.classify.constantize.find(id)
  end

  def staff_params
    params.require(:staff).permit(:name, :staffable_id, :staffable_type, :email, :password, :username)
  end
end
