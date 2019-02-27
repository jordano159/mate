json.set! :data do
  json.array! @staffs do |staff|
    if staff.staffable
      edit = eval("edit_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      delete = eval("#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      become = eval("become_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      json.name "#{link_to staff.name, become}"
      json.url  "
                #{link_to 'עריכה', edit, class: 'btn btn-warning'}
                #{link_to 'מחיקה', delete, method: :delete, class: 'btn btn-danger'}
                "
    else
      json.name "#{staff.name}"
      json.url  " "
    end
    json.username "#{staff.username}"
  end
end
