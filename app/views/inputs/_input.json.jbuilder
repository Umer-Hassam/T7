json.extract! input, :id, :name, :image_url, :is_direction, :created_at, :updated_at
json.url input_url(input, format: :json)
