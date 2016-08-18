class AddReceiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive, :boolean, default: true
  end
end
