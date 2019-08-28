json.set! :data do
  json.array! @groups do |group|
    json.name "#{link_to group.name, group}"
    json.url  "
              #{link_to '<i class="fas fa-edit"></i>'.html_safe, edit_group_path(group), class:"text-muted"}
              #{link_to "<i class='far fa-trash-alt'></i>".html_safe, group, method: :delete, data: { confirm: 'את/ה בטוח/ה?' },class:"mx-2 text-danger" if current_staff.admin? || current_staff.vip?}
              "
    json.group_counter "
     <strong class='for_sum'>#{how_many_attending(group.kids)}</strong> מתוך <strong> #{group.kids.count} </strong>
    "
    if group.checks.exists?
      if group.checks.last.approved?
        json.last_attendence "<span style='color:green;'>  #{group.checks.last.name} </span> <i class='fa fa-check-circle'></i>"
      else
       json.last_attendence "<span style='color:red;'>  #{link_to group.checks.last.name, check_path(Check.find(group.checks.last.id)), class: "check-link"} </span>"
      end
    else
      json.last_attendence "לא נעשתה עדיין נוכחות..."
    end

  end
end
