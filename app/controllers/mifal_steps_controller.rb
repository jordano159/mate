class MifalStepsController < ApplicationController
  include Wicked::Wizard
  before_action :check_permission

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
      @mifal.axised! # Set stage
      axis_num = params[:mifal][:axis_num].to_i
      (1..axis_num).each do |i|
        Axis.create(name: "ציר #{i} #{@mifal.name}", mifal_id: @mifal.id) if Axis.find_by(name: "ציר #{i} #{@mifal.name}").nil?
        next unless Staff.find_by(username: "ציר #{i} #{@mifal.name}").nil?

        Staff.create(name: "רכזת ציר #{i} #{@mifal.name}", email: "a#{@mifal.name}#{i}@gmail.com", password: '123123',
          password_confirmation: '123123', role: 'user', username: "ציר #{i} #{@mifal.name}", staffable_type: 'Axis',
          staffable_id: Axis.find_by(name: "ציר #{i} #{@mifal.name}").id)
      end
    when :headed
      @mifal.headed! # Set stage
      head_nums = []
      @mifal.axes.count.times do |i|
        head_nums << params[:mifal]["head_num_#{i}"].to_i
      end
      counter = 1
      @mifal.axes.each_with_index do |axis,i|
        head_nums[i].times do
          Head.create(name: "ראש #{counter} #{@mifal.name}", axis_id: axis.id) if Head.find_by(name: "ראש #{counter} #{@mifal.name}").nil?
          next unless Staff.find_by(username: "ראש #{counter} #{@mifal.name}").nil?

          Staff.create(name: "ראשראשית #{counter} #{@mifal.name}", email: "h#{@mifal.name}#{counter}@gmail.com", password: '123123',
            password_confirmation: '123123', role: 'user', username: "ראש #{counter} #{@mifal.name}", staffable_type: 'Head',
            staffable_id: Head.find_by(name: "ראש #{counter} #{@mifal.name}").id)
          counter += 1
        end
      end
    when :grouped
      @mifal.grouped! # Set stage
      group_nums = []
      @mifal.heads.count.times do |i|
        group_nums << params[:mifal]["group_num_#{i}"].to_i
      end
      counter = 1
      @mifal.heads.each_with_index do |head,i|
        group_nums[i].times do
          Group.create(name: "קבוצה #{counter} #{@mifal.name}", head_id: head.id) if Group.find_by(name: "קבוצה #{counter} #{@mifal.name}").nil?
          next unless Staff.find_by(username: "קבוצה #{counter} #{@mifal.name}").nil?

          Staff.create(name: "מדריכת #{counter} #{@mifal.name}", email: "g #{@mifal.name}#{counter}@gmail.com", password: '321321', password_confirmation: '321321',
                        role: 'user', username: "קבוצה #{counter} #{@mifal.name}", staffable_type: 'Group',
                        staffable_id: Group.find_by(name: "קבוצה #{counter} #{@mifal.name}").id)
          counter += 1
        end
      end
    end
    @mifal.update(mifal_params)
    render_wizard @mifal
  end

  private
    def check_permission
      unless current_staff.admin? || current_staff.vip?
        redirect_to root_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, axis_ids: [])
    end
end