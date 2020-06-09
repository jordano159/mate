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
      if group.checks.last.approved?
        json.last_attendence "<span style='color:green;'><i class='icon icon-check-circle-regular'></i> #{group.checks.last.name}</span>"
      else
       json.last_attendence "<span style='color:red;'>  #{link_to group.checks.last.name, check_path(Check.find(group.checks.last.id)), class: "check-link"} </span>"
      end
    else
      json.last_attendence "לא נעשתה עדיין נוכחות..."
    end

  end
end
