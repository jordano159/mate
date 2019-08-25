json.set! :data do
  json.array! @staffs do |staff|
    if staff.staffable
      edit = eval("edit_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      delete = eval("#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      become = eval("become_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      json.name "#{link_to staff.name, become}"
      json.url  "
                #{link_to '<i class="fas fa-edit"></i>'.html_safe, edit,  style: 'color: grey', class:'ml-2'}
                #{link_to '<i class="far fa-trash-alt"></i>'.html_safe, delete, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, style: 'color: red'}
                "
    else
      json.name "#{staff.name}"
      json.url  " "
    end
    json.username "#{staff.username}"
  end
end
