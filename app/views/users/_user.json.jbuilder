json.extract! user, :id, :name, :email, :mail_trigger_time, :created_at, :updated_at
json.url user_url(user, format: :json)
