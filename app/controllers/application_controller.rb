# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_staff!
  before_action :level
  before_action :level_names
  before_action :staff_names
  before_action :columns_settings
  before_action :clearence
  before_action :only_admin
  before_action :configure_permitted_parameters, if: :devise_controller?
  # after_action :track_action


def columns_settings
  if staff_signed_in?
    @column_names = {
      full_name: "שם מלא",
      status: "סטטוס",
      cause: "סיבה",
      group: "#{@level_names[0]}",
      sex: "מין",
      taz: "תעודת זהות",
      ken: "קן",
      grade: "שכבה",
      phone: "טלפון",
      medical: "רגישות ובעיות רפואיות",
      meds: "תרופות",
      food: "אוכל",
      comments: "הערות",
      city: "יישוב",
      parent_1: "שם הורה 1",
      parent_1_phone: "טלפון הורה 1",
      parent_2: "שם הורה 2",
      parent_2_phone: "טלפון הורה 2",
      size: "גודל חולצה",
      shabat: "שמירת שבת",
      parents: "ההורים באים לביקור?",
      swim: "אישור שחייה",
      exits: "כניסות ויציאות"
    }

    @default_columns = [
      "full_name",
      "status",
      "cause",
      "group",
      "sex"
    ]
end
end

  def level_names
    if staff_signed_in?
      unless current_staff.admin?
        mifal = current_staff.staffable.mifal
        @level_names = [mifal.group_name[:single], mifal.group_name[:plural],
                        mifal.head_name[:single], mifal.head_name[:plural],
                        mifal.axis_name[:single], mifal.axis_name[:plural]]
      else
        @level_names = %w(קבוצה קבוצות ראש ראשים ציר צירים)
      end
    end
  end


  def staff_names
    if staff_signed_in?
      unless current_staff.admin?
        mifal = current_staff.staffable.mifal
        @staff_names = [mifal.guide_name[:single], mifal.guide_name[:plural],
                        mifal.head_head_name[:single], mifal.head_head_name[:plural]]
      else
        @staff_names = %w(מדריך מדריכות ראשראשית ראשראשים)
      end
    end
  end

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
        if blocked.include?(controller_name) && ((action_name == 'new') || (action_name == 'destroy'))
          redirect_to controller: current_staff.staffable_type.downcase.pluralize, action: 'show', id: current_staff.staffable_id
        end
      end
    end
  end

  def track_action
    ahoy.track "Processed #{controller_name}##{action_name}", request.filtered_parameters
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
