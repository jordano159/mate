class MifalStepsController < ApplicationController
  include Wicked::Wizard
  before_action :check_permission

  steps :settings, :axised, :headed, :grouped, :imported_kids, :done

  def show
    @mifal = current_staff.staffable
    case step
    when :done
      redirect_to root_path
    else
      render_wizard
    end
  end

  def update
    @mifal = current_staff.staffable
    case step
    when :settings
      @mifal.settings! # Set stage
      @mifal.update(mifal_params)
      @mifal.columns.delete("")
      @mifal.columns.unshift("name", "last_name", "full_name", "taz", "group", "status", "cause")
      group_name_single = params[:mifal][:group_name_single]
      group_name_plural = params[:mifal][:group_name_plural]
      @mifal.group_name = {single: group_name_single, plural: group_name_plural}
      head_name_single = params[:mifal][:head_name_single]
      head_name_plural = params[:mifal][:head_name_plural]
      @mifal.head_name = {single: head_name_single, plural: head_name_plural}
      axis_name_single = params[:mifal][:axis_name_single]
      axis_name_plural = params[:mifal][:axis_name_plural]
      @mifal.axis_name = {single: axis_name_single, plural: axis_name_plural}
      guide_name_single = params[:mifal][:guide_name_single]
      guide_name_plural = params[:mifal][:guide_name_plural]
      @mifal.guide_name = {single: guide_name_single, plural: guide_name_plural}
      head_head_name_single = params[:mifal][:head_head_name_single]
      head_head_name_plural = params[:mifal][:head_head_name_plural]
      @mifal.head_head_name = {single: head_head_name_single, plural: head_head_name_plural}
      @mifal.save

    when :axised
      @mifal.axised! # Set stage
      if @mifal.has_axes
        axis_num = params[:mifal][:axis_num].to_i
      else
        axis_num = 1
      end
        (1..axis_num).each do |i|
          Axis.create(name: "#{@level_names[4]} #{i} #{@mifal.name}", hard_name: "#{@level_names[4]} #{i} #{@mifal.name}",
                      mifal_id: @mifal.id) if Axis.find_by(hard_name: "#{@level_names[4]} #{i} #{@mifal.name}").nil?
          next unless Staff.find_by(username: "#{@level_names[4]} #{i} #{@mifal.name}").nil?

          Staff.create(name: "רכזת #{@level_names[4]} #{i} #{@mifal.name}", email: "a#{@mifal.name}#{i}@gmail.com", password: '123123',
            password_confirmation: '123123', role: 'user', username: "#{@level_names[4]} #{i} #{@mifal.name}", staffable_type: 'Axis',
            staffable_id: Axis.find_by(hard_name: "#{@level_names[4]} #{i} #{@mifal.name}").id)
          end

    when :headed
      @mifal.headed! # Set stage
      head_nums = []
      @mifal.axes.count.times do |i|
        head_nums << params[:mifal]["head_num_#{i}"].to_i
      end
      counter = 0
      @mifal.axes.order(:hard_name.to_s.gsub(/\D/, '')).each_with_index do |axis,i|
        head_nums[i].times do
          counter += 1
          Head.create(name: "#{@level_names[2]} #{counter} #{@mifal.name}", hard_name: "#{@level_names[2]} #{counter} #{@mifal.name}",
                      axis_id: axis.id) if Head.find_by(hard_name: "#{@level_names[2]} #{counter} #{@mifal.name}").nil?
          next unless Staff.find_by(username: "#{@level_names[2]} #{counter} #{@mifal.name}").nil?

          Staff.create(name: "#{@staff_names[2]} #{counter} #{@mifal.name}", email: "h#{@mifal.name}#{counter}@gmail.com", password: '123123',
            password_confirmation: '123123', role: 'user', username: "#{@level_names[2]} #{counter} #{@mifal.name}", staffable_type: 'Head',
            staffable_id: Head.find_by(hard_name: "#{@level_names[2]} #{counter} #{@mifal.name}").id)
        end
      end

    when :grouped
      @mifal.grouped! # Set stage
      group_nums = []
      @mifal.heads.count.times do |i|
        group_nums << params[:mifal]["group_num_#{i}"].to_i
      end
      counter = 0
      @mifal.heads.order(:hard_name.to_s.gsub(/\D/, '')).each_with_index do |head,i|
        diff = group_nums[i] - head.groups.count
        puts "~~~~~~~~~~~ #{head.name} ~~~~~~~~~~~~~"
        puts "~~~~~~~~~~~ Counter: #{counter} ~~~~~~~~~~~~~"
        puts "~~~~~~~~~~~ Diff: #{diff} ~~~~~~~~~~~~~"
        if diff > 0
          group_nums[i].times do
          # diff.times do
            counter += 1
            g = Group.create(name: "#{ @level_names[0] } #{counter} #{@mifal.name}", hard_name: "#{ @level_names[0] } #{counter} #{@mifal.name}",
                         head_id: head.id, mifal_id: @mifal.id) if Group.find_by(hard_name: "#{ @level_names[0] } #{counter} #{@mifal.name}").nil?
            next unless Staff.find_by(username: "#{ @level_names[0] } #{counter} #{@mifal.name}").nil?
            puts  "~~~~~~~~~~~ #{head.name} ~~~~~~~~~~~~~ #{g.name}"

            Staff.create(name: "#{@staff_names[0]} #{counter} #{@mifal.name}", email: "g #{@mifal.name}#{counter}@gmail.com", password: '321321', password_confirmation: '321321',
                         role: 'user', username: "#{ @level_names[0] } #{counter} #{@mifal.name}", staffable_type: 'Group',
                         staffable_id: Group.find_by(hard_name: "#{ @level_names[0] } #{counter} #{@mifal.name}").id)
          end
        else
          counter += head.groups.count
        end
      end
      Group.create(name: "סל מחזור #{@mifal.name}", hard_name: "סל מחזור #{@mifal.name}",
                   mifal_id: @mifal.id) if Group.find_by(hard_name: "סל מחזור #{@mifal.name}").nil?
    end
    render_wizard @mifal
  end

  private
    def check_permission
      unless current_staff.vip?
        redirect_to root_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def mifal_params
      params.require(:mifal).permit(:name, :has_buses, :has_events, :has_approve, :has_axes, :has_late, :checks_num, columns: [], axis_ids: [])
    end
end
