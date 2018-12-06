json.set! :data do
  json.array! @axes do |axis|
    json.name "#{link_to axis.name, axis}"
    json.url  "
              #{link_to 'עריכה', edit_axis_path(axis), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', axis, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
    json.axis_counter "
     <strong>#{how_many_attending(axis.kids)}</strong> מתוך <strong> #{axis.kids.count} </strong>
    "
  end
end
