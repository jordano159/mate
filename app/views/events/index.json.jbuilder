# frozen_string_literal: true


json.set! :data do
  json.array! @events do |event|
    json.content "#{event.content}"
    json.date "#{event.created_at.in_time_zone('Jerusalem').strftime('%H:%M | %e.%m')}"
    json.made "#{event.staff.name}"
    json.belongs "#{link_to event.eventable.name, event.eventable if event.eventable}"
    json.url  "
              #{link_to 'עריכה', edit_event_path(event), class: 'btn btn-warning'}
              #{link_to 'מחיקה', event, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
  end
end
