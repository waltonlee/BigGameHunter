class AddReferencesToGames < ActiveRecord::Migration
  def change
    add_reference :games, :gametype, index: true, foreign_key: true
  end
end
