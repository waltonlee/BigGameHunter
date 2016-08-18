json.extract! game, :id, :name, :start_time, :end_time, :user_id, :created_at, :updated_at
json.url game_url(game, format: :json)