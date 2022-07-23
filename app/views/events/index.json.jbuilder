event_levels = {
  auto: "אוטומטי",
  regular: "רגיל",
  critical: "חמור"
}

json.set! :data do
  json.array! @events do |event|
    json.content "#{event.content}"
    json.date "#{event.created_at.in_time_zone('Jerusalem').strftime('%H:%M | %e.%m')}"
    json.made "#{event.staff.name}"
    json.belongs "#{link_to event.eventable.name, event.eventable if event.eventable}"
    json.kind "#{event.kind}"
    if event.level.present?
      json.level "#{event_levels[event.level.to_sym]}"
    else
      json.level "לא הוכנסה דרגה"
    end
    json.url  "
              #{link_to '<i class="icon icon-edit-solid"></i>'.html_safe, edit_event_path(event), style: 'color: grey; margin-right: 30px;'}
              #{link_to '<i class="icon icon-trash-alt-regular"></i>'.html_safe, event, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, style: 'color: red' if current_staff.admin? || current_staff.vip?}
              "
  end
end
