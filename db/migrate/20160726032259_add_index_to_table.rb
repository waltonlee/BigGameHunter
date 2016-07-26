class AddIndexToTable < ActiveRecord::Migration
  def change
  	add_index :games, [:start, :created_at]
  end
end
