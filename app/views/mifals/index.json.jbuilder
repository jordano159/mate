json.set! :data do
  json.array! @mifals do |mifal|
    json.name "#{link_to mifal.name, mifal}"
    json.url  "
              #{link_to 'ייצוא', mifal_path(mifal, format: :xlsx), class: 'btn btn-primary' if current_staff.admin? || current_staff.vip?}
              #{link_to 'עריכה', edit_mifal_path(mifal), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', mifal, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
    json.mifal_counter "
     <strong class='for_sum'>#{how_many_attending(mifal.kids)}</strong> מתוך <strong> #{mifal.kids.count} </strong>
    "
  end
end
