json.extract! contact, :id, :name, :email, :message, :tel, :created_at, :updated_at
json.url contact_url(contact, format: :json)
