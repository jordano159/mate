json.set! :data do
  json.array! @mifals do |mifal|
    json.partial! 'mifals/mifal', mifal: mifal
    json.url  "
              #{link_to 'Show', mifal }
              #{link_to 'Edit', edit_mifal_path(mifal)}
              #{link_to 'Destroy', mifal, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end