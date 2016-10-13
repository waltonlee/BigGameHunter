#json.array! @games, :id, :name, :start_time, :end_time, :user_id, :created_at, :updated_at, :latitude, :longitude, :description, :gametype

json.array! @games do |game|
  json.name game.name
  json.start_time game.start_time
  json.end_time game.end_time
  json.creator game.user.name
  json.latitude game.latitude
  json.longitude game.longitude
  json.gametype game.gametype.name
  json.image game.gametype.image
  json.description game.description
end
