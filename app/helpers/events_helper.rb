# frozen_string_literal: true

module EventsHelper
  def event_options
    case @level
      when 1
        options = [["#{ @level_names[1] }:",[[current_staff.staffable.name, current_staff.staffable.id]]]]
      when 2
        options = [["#{ @level_names[1] }:",current_staff.staffable.groups.pluck(:name, :id)],
                      ["#{ @level_names[3] }:",[[current_staff.staffable.name, current_staff.staffable.id]]]]
      when 3
        options = [["#{ @level_names[1] }:",current_staff.staffable.groups.pluck(:name, :id)],
                      ["#{ @level_names[3] }:",current_staff.staffable.heads.pluck(:name, :id)]]
        if current_staff.staffable.mifal.has_axes
          options << ["#{ @level_names[5] }:",[[current_staff.staffable.name, current_staff.staffable.id]]]
        end
      when 4
        if current_staff.vip?
          excluded = current_staff.staffable.groups.where("name LIKE :prefix", prefix: "סל מחזור%").first.name
          options = [
                        ["#{ @level_names[1] }:",current_staff.staffable.groups.pluck(:name, :id).reject { |x| excluded.include?(x[0]) }],
                        ["#{ @level_names[3] }:",current_staff.staffable.heads.pluck(:name, :id)]]
          if current_staff.staffable.has_axes
            options << ["#{ @level_names[5] }:",current_staff.staffable.axes.pluck(:name, :id)]
          end
          options << ['מפעל:',[[current_staff.staffable.name, current_staff.staffable.id]]]

        end
        when 5
          if current_staff.admin?
            excluded = Group.all.where("name LIKE :prefix", prefix: "סל מחזור%").pluck(:name)
            options = [
                          ["#{ @level_names[1] }:",Group.all.pluck(:name, :id).reject { |x| excluded.include?(x[0]) }],
                          ["#{ @level_names[3] }:",Head.all.pluck(:name, :id)],
                          ["#{ @level_names[5] }:",Axis.all.pluck(:name, :id)],
                          ['מפעלים:',Mifal.all.pluck(:name, :id)]
                          ]
          end
    end
  end
end
