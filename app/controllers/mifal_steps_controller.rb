class MifalStepsController < ApplicationController
  include Wicked::Wizard

  steps :axised, :headed, :grouped, :imported_kids, :associated_kids, :buses_created, :done

  def show
    @mifal = current_staff.staffable
    render_wizard
  end

  def update
    @mifal = current_staff.staffable
    @mifal.update(mifal_params)
    render_wizard @mifal
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, axis_ids: [])
    end
end
