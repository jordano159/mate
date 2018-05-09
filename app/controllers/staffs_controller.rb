class StaffsController < ApplicationController
  before_action :load_staffable
  def index
    @staffs = @staffable.staffs
  end

  def new
    @staff = Staff.new
  end

  def create
  @staff = @staffable.staffs.new(staff_params)
  if @staff.save
    redirect_to [@staffable, :staffs], notice: 'Staff created'
  else
    render :new
  end
end

  private

  def load_staffable
    resource, id = request.path.split('/')[1,2]
    @staffable = resource.singularize.classify.constantize.find(id)
  end

  def staff_params
    params.require(:staff).permit(:name, :staffable_id, :staffable_type)
  end
end
