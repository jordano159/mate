class ApplicationController < ActionController::Base
before_action :level

private

def level
  if staff_signed_in?
    case current_staff.staffable_type
    when Group
      @level = 1
    when Head
      @level = 2
    when Axis
      @level = 3
    end
  else
    @level = 0
  end
end
end
