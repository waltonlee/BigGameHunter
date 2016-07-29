class CreateJoinTableGametypesUsers < ActiveRecord::Migration
  def change
    create_join_table :gametypes, :users do |t|
      t.index [:gametype_id, :user_id]
      t.index [:user_id, :gametype_id]
    end
  end
end
