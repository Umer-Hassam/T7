json.extract! fan_art, :id, :link, :artist_name, :artist_link, :art_type, :style, :is_main, :description, :created_at, :updated_at
json.url fan_art_url(fan_art, format: :json)
