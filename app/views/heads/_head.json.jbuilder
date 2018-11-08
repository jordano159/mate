# frozen_string_literal: true

json.extract! head, :id, :name, :created_at, :updated_at
json.url head_url(head, format: :json)
