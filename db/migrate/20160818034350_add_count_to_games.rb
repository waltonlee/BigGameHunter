class AddCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :count, :integer, default: 0
  end
end
