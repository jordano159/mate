json.set! :data do
  json.array! @heads do |head|
    json.name "#{link_to head.name, head}"
    json.url  "
              #{link_to '<i class="fas fa-edit"></i>'.html_safe, edit_head_path(head), style: 'color: grey'}
              #{link_to "<i class='far fa-trash-alt'></i>".html_safe, head, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class:"mx-2", style: "color: red" if current_staff.admin? || current_staff.vip?}
              "
    json.head_counter "
     <strong class='for_sum'>#{how_many_attending(head.kids)}</strong> מתוך <strong> #{head.kids.count} </strong>
    "
  end
end
