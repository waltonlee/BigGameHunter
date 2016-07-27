class CreateJoinTableAttendedEventsAttendees < ActiveRecord::Migration
  def change
    create_join_table :games, :users do |t|
      t.index [:game_id, :user_id], :unique => true , :name => "attended_to_attendees"
      t.index [:user_id, :game_id], :unique => true, :name => "attendees_to_attended"
    end
  end
end
