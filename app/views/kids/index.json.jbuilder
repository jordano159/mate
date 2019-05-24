json.set! :data do
  json.array! @kids do |kid|
    json.first_name "#{link_to kid.name, kid}"
    json.last_name "#{kid.last_name}"
    json.full_name "#{link_to kid.full_name, kid}"
    json.phone "#{kid.phone}"
    json.medical "#{kid.medical}"
    json.meds "#{kid.meds}"
    json.food "#{kid.food}"
    json.ken "#{kid.ken}"
    json.city "#{kid.city}"
    json.exits "#{kid.exits}"
    json.status "#{button_to kid.heb_status, toggle_path, method: :get, params: { value: 1 - kid.status, id: kid.id}}"
    json.cause "#{kid.cause}"
    if kid.group.present?
      json.group "#{link_to kid.group.name, kid.group}"
    else
      json.group "אין קבוצה משוייכת"
    end
    json.url  "
              #{link_to 'עריכה', edit_kid_path(kid), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', kid, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
  end
end
