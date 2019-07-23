# frozen_string_literal: true

module EventsHelper
  def event_options
    case @level
      when 1
        options = [['קבוצות:',[[current_staff.staffable.name, current_staff.staffable.id]]]]
      when 2
        options = [['קבוצות:',current_staff.staffable.groups.pluck(:name, :id)],
                      ['ראשים:',[[current_staff.staffable.name, current_staff.staffable.id]]]]
      when 3
        options = [['קבוצות:',current_staff.staffable.groups.pluck(:name, :id)],
                      ['ראשים:',current_staff.staffable.heads.pluck(:name, :id)],
                      ['צירים:',[[current_staff.staffable.name, current_staff.staffable.id]]]]
      when 4
        if current_staff.vip?
          options = [
                        ['קבוצות:',current_staff.staffable.groups.pluck(:name, :id)],
                        ['ראשים:',current_staff.staffable.heads.pluck(:name, :id)],
                        ['צירים:',current_staff.staffable.axes.pluck(:name, :id)],
                        ['מפעל:',[[current_staff.staffable.name, current_staff.staffable.id]]]
                        ]
        end
        when 5
          if current_staff.admin?
            options = [
                          ['קבוצות:',Group.all.pluck(:name, :id)],
                          ['ראשים:',Head.all.pluck(:name, :id)],
                          ['צירים:',Axis.all.pluck(:name, :id)],
                          ['מפעלים:',Mifal.all.pluck(:name, :id)]
                          ]
          end
    end
  end
end
