json.set! :data do
  json.array! @kids do |kid|
    json.full_name "#{link_to kid.full_name, kid}"
    json.status "#{kid.heb_status}"
    json.cause "#{kid.cause}"
    json.jan "#{kid.total_per_month[1]} / #{kid.absences_per_month[1]}"
    json.feb "#{kid.total_per_month[2]} / #{kid.absences_per_month[2]}"
    json.mar "#{kid.total_per_month[3]} / #{kid.absences_per_month[3]}"
    json.apr "#{kid.total_per_month[4]} / #{kid.absences_per_month[4]}"
    json.may "#{kid.total_per_month[5]} / #{kid.absences_per_month[5]}"
    json.jun "#{kid.total_per_month[6]} / #{kid.absences_per_month[6]}"
    json.jul "#{kid.total_per_month[7]} / #{kid.absences_per_month[7]}"
    json.aug "#{kid.total_per_month[8]} / #{kid.absences_per_month[8]}"
    json.sep "#{kid.total_per_month[9]} / #{kid.absences_per_month[9]}"
    json.oct "#{kid.total_per_month[10]} / #{kid.absences_per_month[10]}"
    json.nov "#{kid.total_per_month[11]} / #{kid.absences_per_month[11]}"
    json.dec "#{kid.total_per_month[12]} / #{kid.absences_per_month[12]}"
    if kid.group.present?
      json.group "#{link_to kid.group.name, kid.group}"
    else
      json.group "אין #{@level_names[0]} משוייכת"
    end

  end
end
