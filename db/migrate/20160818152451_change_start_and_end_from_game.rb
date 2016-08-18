class ChangeStartAndEndFromGame < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.rename :start, :start_time
      t.rename :end, :end_time
	end
  end
end
