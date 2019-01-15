class MifalStepsController < ApplicationController
  include Wicked::Wizard

  steps :axised, :headed, :grouped, :imported_kids, :done

  def show
    @mifal = current_staff.staffable
    case step
    when :done
      redirect_to buses_path
    else
      render_wizard
    end
  end

  def update
    @mifal = current_staff.staffable
    case step
    when :axised
      axis_num = params[:mifal][:axis_num].to_i
      (1..axis_num).each do |i|
        Axis.create(name: "ציר #{i} #{@mifal.name}", mifal_id: @mifal.id) if Axis.find_by(name: "ציר #{i} #{@mifal.name}").nil?
        next unless Staff.find_by(username: "ציר #{i} #{@mifal.name}").nil?

        Staff.create(name: "רכזת ציר #{i} #{@mifal.name}", email: "a#{@mifal.name}#{i}@gmail.com", password: '123123',
          password_confirmation: '123123', role: 'user', username: "ציר #{i} #{@mifal.name}", staffable_type: 'Axis',
          staffable_id: Axis.find_by(name: "ציר #{i} #{@mifal.name}").id)
      end
    when :headed
      head_num = params[:mifal][:head_num].to_i
      head_in_axis_num = params[:mifal][:head_in_axis_num].to_i
      (1..head_num).each do |i|
        Head.create(name: "ראש #{i} #{@mifal.name}",
        axis_id: Axis.find_by(name: "ציר #{(i / (head_in_axis_num + 1)) + 1} #{@mifal.name}").id.to_s) if Head.find_by(name: "ראש #{i} #{@mifal.name}").nil?
        next unless Staff.find_by(username: "ראש #{i} #{@mifal.name}").nil?
        #בעיה בחישוב של שיוך הראש לציר הנכון
        Staff.create(name: "ראשראשית #{i} #{@mifal.name}", email: "h#{@mifal.name}#{i}@gmail.com", password: '123123',
          password_confirmation: '123123', role: 'user', username: "ראש #{i} #{@mifal.name}", staffable_type: 'Head',
          staffable_id: Head.find_by(name: "ראש #{i} #{@mifal.name}").id)
      end
    when :grouped
      group_num = params[:mifal][:group_num].to_i
      group_in_head_num = params[:mifal][:group_in_head_num].to_i
      (1..group_num).each do |i|
        Group.create!(name: "קבוצה #{i} #{@mifal.name}",
          head_id: Head.find_by(name: "ראש #{(i / (group_in_head_num + 1)) + 1} #{@mifal.name}").id.to_s) if Group.find_by(name: "קבוצה #{i} #{@mifal.name}").nil?
        next unless Staff.find_by(username: "קבוצה #{i} #{@mifal.name}").nil?

        Staff.create!(name: "מדריכת #{i} #{@mifal.name}", email: "g #{@mifal.name}#{i}@gmail.com", password: '321321', password_confirmation: '321321',
                      role: 'user', username: "קבוצה #{i} #{@mifal.name}", staffable_type: 'Group',
                      staffable_id: Group.find_by(name: "קבוצה #{i} #{@mifal.name}").id)
      end
    end
    @mifal.update(mifal_params)
    render_wizard @mifal
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, axis_ids: [])
    end
end
