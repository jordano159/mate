json.set! :data do
  json.array! @groups do |group|
    json.name "#{link_to group.name, group}"
    json.url  "
              #{link_to 'עריכה', edit_group_path(group), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', group, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
    json.group_counter "
     <strong>#{how_many_attending(group.kids)}</strong> מתוך <strong> #{group.kids.count} </strong>
    "
    if group.checks.exists?
      if group.checks.last.approved?
        json.last_attendence "<span style='color:green;'>  #{group.checks.last.name} </span> <i class='fa fa-check-circle'></i>"
      else
       json.last_attendence "<span style='color:red;'>  #{group.checks.last.name} </span>"
      end
    else
      json.last_attendence "לא נעשתה עדיין נוכחות..."
    end

  end
end
