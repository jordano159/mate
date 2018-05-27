class ApplicationController < ActionController::Base
  before_action :authenticate_staff!
  before_action :level
  before_action :clearence

def root
  if staff_signed_in?
    if current_staff.admin?
      root 'axes#index'
    else
      redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: "show", id: current_staff.staffable_id
    end
  else
    root 'axes#index'
  end
end

  private

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
        redirect_to heads_path, notice: 'אין לך הרשאה לצפות בזה'
      end
    when "heads"
      if @level < 2
        redirect_to groups_path, notice: 'אין לך הרשאה לצפות בזה'
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
