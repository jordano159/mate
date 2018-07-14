json.extract! event, :id, :content, :staff_id, :eventable_id, :eventable_type, :created_at, :updated_at
json.url event_url(event, format: :json)
