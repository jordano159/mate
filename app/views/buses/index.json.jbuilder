json.set! :data do
  json.array! @buses do |bus|
    json.partial! 'buses/bus', bus: bus
    json.url  "
              #{link_to 'Show', bus }
              #{link_to 'Edit', edit_bus_path(bus)}
              #{link_to 'Destroy', bus, method: :delete, data: { confirm: 'Are you sure?' }}
              "
    json.bus_counter "
     <strong>#{how_many_attending(bus.kids)}</strong> מתוך <strong> #{bus.kids.count} </strong>
    "
  end
end
