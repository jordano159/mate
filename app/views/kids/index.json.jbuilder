json.set! :data do
  json.array! @kids do |kid|
    if kid.group_id.nil? || kid.group.name != "סל מחזור #{kid.mifal.name}"
	    json.name "#{link_to kid.name, kid}"
	    json.last_name "#{kid.last_name}"
	    if params[:bus_id].present?
	      json.full_name "#{kid.full_name}"
	    else
	      json.full_name "#{link_to kid.full_name, kid}"
	    end
	    json.phone "#{link_to kid.phone, 'tel:#{kid.phone}' if kid.phone.present?}"
	    json.medical "#{kid.medical}"
	    json.meds "#{kid.meds}"
	    json.food "#{kid.food}"
	    json.ken "#{kid.ken}"
	    json.city "#{kid.city}"
	    json.exits "#{kid.exits}"
	    json.status "#{kid.heb_status}"
	    json.cause "#{kid.cause}"
	    json.parent_1 "#{kid.parent_1}"
	    json.parent_1_phone "#{kid.parent_1_phone}"
	    json.parent_2 "#{kid.parent_2}"
	    json.parent_2_phone "#{kid.parent_2_phone}"
	    json.grade "#{kid.grade}"
	    json.sex "#{kid.sex}"
	    json.taz "#{kid.taz}"
	    json.comments "#{kid.comments}"
	    json.size "#{kid.size}"
	    json.shabat "#{kid.shabat}"
	    json.parents "#{kid.parents}"
	    json.swim "#{kid.swim}"
      if kid.mifal.check_fever?
        if kid.has_fever?
          json.fever "יש חום"
        elsif
          json.fever "אין חום"
        else
          json.fever "אין מידע"
        end
      end
	    month = Date.current.month
	    json.absences "נעדר #{kid.absences_per_month[month]} פעמים מתוך #{kid.total_per_month[month]} בחודש #{@month_names[month]}"
	    if kid.group.present?
	      json.group "#{link_to kid.group.name, kid.group}"
	    else
	      json.group "אין #{@level_names[0]} משוייכת"
	    end
  	else
	    json.full_name "#{link_to kid.full_name, kid}"
	    json.last_group "#{Group.find(kid.last_group).name}" unless kid.last_group.nil?
	    json.leave_cause "#{kid.leave_cause}"
  	end

    group_hard_name = "סל מחזור #{kid.mifal.name}"
		# puts "*****************סל מחזור******************"
		# puts group_hard_name
    json.url  "
              #{link_to '<i class="icon icon-redo-solid"></i>'.html_safe, recover_path(kid) if kid.group && kid.group.hard_name == group_hard_name}
              #{link_to '<i class="icon icon-edit-solid"></i>'.html_safe, edit_kid_path(kid), class:'text-muted mx-2' if current_staff.admin? || current_staff.vip?}
              "
  end
end
