json.set! :data do
  json.array! @kids do |kid|
    json.full_name "#{link_to kid.full_name, kid}"
    json.status "#{kid.heb_status}"
    json.cause "#{kid.cause}"
    mon = %w(jan feb mar apr may jun jul aug sep oct nov dec)
    mon.each_with_index do |month,i|
      json.set! month.to_sym, "#{kid.attendances_this_month(i)} / #{kid.checks_this_month(i)}"
    end
    names = @mifal.checks.pluck(:name).uniq
    names.delete("Blank")
    names.each_with_index do |name,i|
      json.set! name.to_sym, "#{kid.attendances_on_check(name)[0]} / #{kid.attendances_on_check(name)[1]}"
    end
    if kid.group.present?
      json.group "#{link_to kid.group.name, kid.group}"
    else
      json.group "אין #{@level_names[0]} משוייכת"
    end

  end
end
