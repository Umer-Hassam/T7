json.extract! profile, :id, :nickname, :isadmin, :created_at, :updated_at
json.url profile_url(profile, format: :json)
