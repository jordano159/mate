class ApplicationController < ActionController::Base
  before_action :authenticate_staff!
  before_action :level

  private

  def level
    if staff_signed_in?
      case current_staff.staffable
        when Group then @level = 1
        when Head  then @level = 2
        when Axis  then @level = 3
      end
    else
      @level = 0
    end
  end
end
