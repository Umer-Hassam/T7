json.extract! followup, :id, :is_guaranteed, :hit_status, :explanation, :created_at, :updated_at
json.url followup_url(followup, format: :json)
