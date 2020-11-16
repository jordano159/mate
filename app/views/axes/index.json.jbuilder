json.set! :data do
  json.array! @axes do |axis|
    json.name "#{link_to axis.name, axis}"
    json.url  "
              #{link_to '<i class="icon icon-edit-solid"></i>'.html_safe, edit_axis_path(axis), style: 'color: grey'}
              #{link_to "<i class='icon icon-trash-alt-regular'></i>".html_safe, axis, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, class:"mx-2", style: "color: red" if current_staff.admin? || current_staff.vip?}
              "
    json.axis_counter "
     <strong class='for_sum'>#{how_many_attending(axis.active_kids, axis)}</strong> מתוך <strong> #{axis.active_kids.count} </strong>
    "
  end
end
