json.set! :data do
  json.array! @kids do |kid|
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
    if kid.group.present?
      json.group "#{link_to kid.group.name, kid.group}"
    else
      json.group "אין #{@level_names[0]} משוייכת"
    end
    json.url  "
              #{link_to 'עריכה', edit_kid_path(kid), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', kid, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
  end
end
