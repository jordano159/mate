json.set! :data do
  json.array! @buses do |bus|
    json.name "#{link_to bus.name, bus}"
    json.url  "
              #{link_to 'עריכה', edit_bus_path(bus), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', bus, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
    if bus.kids.exists?
      json.bus_counter "
      <strong>#{how_many_attending(bus.kids)}</strong> מתוך <strong> #{bus.kids.count} </strong>
      "
      json.last_stop "
      #{bus.last_updated_kid.city} בשעה #{bus.last_updated_kid.updated_at.in_time_zone("Jerusalem").strftime('%H:%M')}
      "
    else
      json.bus_counter "אין חניכים באוטובוס..."
      json.last_stop "אין חניכים באוטובוס..."
    end
  end
end
