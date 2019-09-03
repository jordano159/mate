json.set! :data do
  json.array! @kids do |kid|
    unless kid.group.name == "סל מחזור #{kid.mifal.name}"
    json.name "#{link_to kid.name, kid}"
    json.last_name "#{kid.last_name}"
    json.full_name "#{link_to kid.full_name, kid}"
    json.phone "#{link_to kid.phone, 'tel:#{kid.phone}' if kid.phone.present?}"
    json.medical "#{kid.medical}"
    json.meds "#{kid.meds}"
    json.food "#{kid.food}"
    json.ken "#{kid.ken}"
    json.city "#{kid.city}"
    json.exits "#{kid.exits}"
    json.status "#{kid.heb_status}"
    json.cause "#{kid.cause}"
    json.parent_1 "#{kid.parent_1}"
    json.parent_1_phone "#{kid.parent_1_phone}"
    json.parent_2 "#{kid.parent_2}"
    json.parent_2_phone "#{kid.parent_2_phone}"
    json.grade "#{kid.grade}"
    json.sex "#{kid.sex}"
    json.taz "#{kid.taz}"
    json.comments "#{kid.comments}"
    json.size "#{kid.size}"
    json.shabat "#{kid.shabat}"
    json.parents "#{kid.parents}"
    json.swim "#{kid.swim}"
    month = Date.current.month
    json.absences "נעדר #{kid.absences_per_month[month]} פעמים מתוך #{kid.total_per_month[month]} בחודש #{@month_names[month]}"
    if kid.group.present?
      json.group "#{link_to kid.group.name, kid.group}"
    else
      json.group "אין #{@level_names[0]} משוייכת"
    end
  else
    json.full_name "#{link_to kid.full_name, kid}"
    json.last_group "#{Group.find(kid.last_group).name}"
    json.leave_cause "#{kid.leave_cause}"
  end

    group_hard_name = "סל מחזור #{kid.mifal.name}"
    json.url  "
              #{link_to '<i class="fas fa-redo"></i>'.html_safe, recover_path(kid) if kid.group && kid.group.hard_name == group_hard_name}
              #{link_to '<i class="fas fa-edit"></i>'.html_safe, edit_kid_path(kid), class:'text-muted mx-2' if current_staff.admin? || current_staff.vip?}
              "
  end
end
