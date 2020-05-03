json.set! :data do
  json.array! @staffs do |staff|
    if staff.staffable && @level > 3
      edit = eval("edit_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      delete = eval("#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      become = eval("become_#{staff.staffable_type.downcase}_staff_path(#{eval('#{staff.staffable_type.downcase}_id:')} #{staff.staffable.id}, id: #{staff.id})")
      json.name "#{link_to staff.name, become, data: { confirm: 'המשך יעביר אותך לתוך המשתמש. את/ה בטוח/ה?' }}"
      json.url  "
                #{link_to '<i class="icon icon-edit-solid"></i>'.html_safe, edit,  style: 'color: grey', class:'ml-2'}
                #{link_to '<i class="icon icon-trash-alt-regular"></i>'.html_safe, delete, method: :delete, data: { confirm: 'את/ה בטוח/ה?' }, style: 'color: red'}
                "
    else
      json.name "#{staff.name}"
      json.url  " "
    end
    json.username "#{staff.username}"
    if staff.phone.present?
      json.phone "#{link_to "", "tel:#{staff.phone}",class:'icon icon-phone-solid icon-size'} #{link_to "", "https://api.whatsapp.com/send?phone=972#{staff.phone}",class:'icon icon-whatsapp-brands icon-size text-success'}"
    else
      json.phone "אין מספר במערכת"
    end
  end
end
