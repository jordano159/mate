json.set! :data do
  json.array! @kids do |kid|
    json.first_name "#{link_to kid.name, kid}"
    json.last_name "#{kid.last_name}"
    json.phone "#{kid.phone}"
    json.medical "#{kid.medical}"
    json.meds "#{kid.meds}"
    json.food "#{kid.food}"
    json.ken "#{kid.ken}"
    json.exits "#{kid.exits}"
    json.status "#{kid.heb_status}"
    json.cause "#{kid.cause}"
    json.group "#{link_to kid.group.name, kid.group}"
  end
end
