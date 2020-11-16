json.set! :data do
  json.array! @mifals do |mifal|
    json.name "#{link_to mifal.name, mifal}"
    json.url  "
              #{link_to "<i class='icon icon-download-solid'></i>".html_safe, mifal_path(mifal, format: :xlsx), class: 'p-2 text-dark' if current_staff.admin? || current_staff.vip?}
              #{link_to "<i class='icon icon-edit-solid'></i>".html_safe, edit_mifal_path(mifal),class: "p-2",  style: "color: grey" if current_staff.admin? || current_staff.vip?}
              #{link_to "<i class='icon icon-trash-alt-regular'></i>".html_safe, mifal, method: :delete, data: { confirm: 'את/ה בטוח/ה?' },class: "p-2", style: "color: red" if current_staff.admin? || current_staff.vip?}
              "
    json.mifal_counter "
     <strong class='for_sum'>#{how_many_attending(mifal.active_kids)}</strong> מתוך <strong> #{mifal.active_kids.count} </strong>
    "
  end
end
