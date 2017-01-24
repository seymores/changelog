json.extract! status, :id, :object_id, :object_type, :timestamp, :state, :created_at, :updated_at
json.url status_url(status, format: :json)