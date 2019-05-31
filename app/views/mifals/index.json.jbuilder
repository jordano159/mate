json.set! :data do
  json.array! @mifals do |mifal|
    json.name "#{link_to mifal.name, mifal}"
    json.url  "
              #{link_to 'גיבוי', mifal_path(mifal, format: :xlsx), class: 'btn btn-primary' if current_staff.admin? || current_staff.vip?}
              #{link_to 'עריכה', edit_mifal_path(mifal), class: 'btn btn-warning' if current_staff.admin? || current_staff.vip?}
              #{link_to 'מחיקה', mifal, method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
              "
  end
end
#{link_to  'מחיקה', mifal(format: :xlsx), method: :delete, class: 'btn btn-danger' if current_staff.admin? || current_staff.vip?}
