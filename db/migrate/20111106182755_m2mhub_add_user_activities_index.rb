class M2mhubAddUserActivitiesIndex < ActiveRecord::Migration
  def self.up
    add_index :user_activities, [:user_id, :created_at], :name => 'user_activities_user_id_created_at'
  end

  def self.down
    remove_index :user_activities, :name => 'user_activities_user_id_created_at'
  end
end
