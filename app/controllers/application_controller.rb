class ApplicationController < ActionController::Base
  before_action :authenticate_staff!
  before_action :level
  before_action :clearence
  before_action :only_admin
  before_action :configure_permitted_parameters, if: :devise_controller?


def home_page
  if staff_signed_in?
    if current_staff.admin?
      redirect_to controller: "axes", action: "index"
    elsif @level == 1
      redirect_to kids_path
    else
      redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: "show", id: current_staff.staffable_id
    end
  else
    redirect_to controller: "axes", action: "index"
  end
end

def admin_index
  redirect_to '/' if !current_staff.admin?
  if params[:search]
    @staffs = Staff.search(params[:search]).order("created_at DESC")
  else
    @staffs = Staff.all.order("created_at DESC")
  end
end

def only_admin
  blocked = %w(kids groups heads axes)
  if staff_signed_in? && current_staff.admin? == false
    if blocked.include?(controller_name) && (action_name == "new" or action_name == "edit" or action_name == "destroy")
      redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: "show", id: current_staff.staffable_id
    end
  end
end

private

  def configure_permitted_parameters
    attributes = [:name, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def level
    if staff_signed_in?
      if current_staff.user?
        case current_staff.staffable
          when Group then @level = 1
          when Head  then @level = 2
          when Axis  then @level = 3
        end
      else
        @level = 4
      end
    else
      @level = 0
    end
  end

  def clearence
    case controller_name
    when "axes"
      if @level < 3
        redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה'
      end
    when "heads"
      if @level < 2
        redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה'
      end
    when "groups"
      if @level < 1
        redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה'
      end
    when "kids"
      if @level < 1
        redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה'
      end
    end
  end
end
