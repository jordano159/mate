json.set! :data do
  json.array! @heads do |head|
    json.name "#{link_to head.name, head}"
    json.url  "
              #{link_to 'עריכה', edit_head_path(head), class: 'btn btn-warning'}
              #{link_to 'מחיקה', head, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
    json.head_counter "
     <strong>#{how_many_attending(head.kids)}</strong> מתוך <strong> #{head.kids.count} </strong>
    "
  end
end
