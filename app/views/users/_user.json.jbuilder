json.extract! user, :id, :email, :username, :first_name, :last_name, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
