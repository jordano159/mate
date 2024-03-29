json.set! :data do
  json.array! @groups do |group|
    json.name "#{link_to group.name, group}"
    json.url  "
              #{link_to '<i class="icon icon-edit-solid"></i>'.html_safe, edit_group_path(group), class:"text-muted"}
              #{link_to "<i class='icon icon-trash-alt-regular'></i>".html_safe, group, method: :delete, data: { confirm: 'את/ה בטוח/ה?' },class:"mx-2 text-danger" if current_staff.admin? || current_staff.vip?}
              "
    json.group_counter "
     <strong class='for_sum'>#{how_many_attending(group.kids)}</strong> מתוך <strong> #{group.kids.count} </strong>
    "
    if group.checks.present? && group.checks.last(2).first.present?
      json.previous_group_counter "
          <strong class='for_sum'>#{how_many_attending(group.checks.last(2).first.attendances)}</strong> מתוך <strong> #{group.checks.last(2).first.kids.count} </strong>
      "
    else
      json.previous_group_counter "אין נוכחות קודמת"
    end
    if group.checks.exists?
      # puts "*******************  group.checks.last: #{group.checks.last.name}  *********************"
      # puts "*******************  group.checks: #{group.checks.pluck(:name)}  *********************"
      # puts "*******************b  group.checks.last: #{group.checks.order(created_at: :asc).last.name}  *********************"
      # puts "*******************b  group.checks: #{group.checks.order(created_at: :asc).pluck(:name)}  *********************"
      last_check = group.last_check
      if last_check.present? && last_check.approved?
        json.last_attendence "<span class='check-approved' style=''><i class='icon icon-check-circle-regular'></i> #{link_to last_check.name, check_path(Check.find(last_check.id)), class: ""} #{last_check.updated_at.strftime('%d/%m')}</span>"
        puts "********************  Last Attendance: #{last_check.name} of #{group.name}  ********************"
      elsif last_check.present?
       json.last_attendence "<span class='check-not-approved' style=''>  #{link_to last_check.name, check_path(Check.find(last_check.id)), class: ""} #{last_check.updated_at.strftime('%d/%m')} </span>"
      else
        json.last_attendence "<span class='' style=''>לא נעשתה עדיין נוכחות...	</span>"
      end
    else
      json.last_attendence "לא נעשתה עדיין נוכחות..."
    end

  end
end
