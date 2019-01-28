# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_staff!
  before_action :level
  before_action :clearence
  before_action :only_admin
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home_page
    if staff_signed_in?
      if @level == 1
        redirect_to kids_path
      elsif @level == 2 || @level == 3 || @level == 4
        redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: 'show', id: current_staff.staffable_id
      elsif @level == 5
        redirect_to mifals_path
      end
    else
      redirect_to controller: 'axes', action: 'index'
    end
  end

  def admin_index
    redirect_to '/' unless current_staff.admin?
    if params[:search]
      @staffs = Staff.search(params[:search]).order('created_at DESC').includes(:staffable)
    else
      @staffs = Staff.all.order('created_at DESC').includes(:staffable)
    end
  end

  def only_admin
    blocked = %w[kids groups heads axes]
    if staff_signed_in?
      unless current_staff.admin? || current_staff.vip?
        if blocked.include?(controller_name) && ((action_name == 'new') || (action_name == 'edit') || (action_name == 'destroy'))
          redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: 'show', id: current_staff.staffable_id
        end
      end
    end
  end

  private

  def configure_permitted_parameters
    attributes = %i[name email]
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
      elsif current_staff.vip?
        @level = 4
      elsif current_staff.admin?
        @level = 5
      end
    else
      @level = 0
    end
  end

  def clearence
    case controller_name
    when 'axes'
      redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה' if @level < 3
    when 'heads'
      redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה' if @level < 2
    when 'groups'
      redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה' if @level < 1
    when 'kids'
      redirect_to root_path, notice: 'אין לך הרשאה לצפות בזה' if @level < 1
    end
  end
end
