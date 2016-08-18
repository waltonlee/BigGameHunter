class AddColumnsToGame < ActiveRecord::Migration
  def change
    add_column :games, :need_players, :boolean, default: false
    add_column :games, :need_count, :integer, default: 0
  end
end
