class M2mhubCreateUserActivities < ActiveRecord::Migration
  def self.up
    create_table :user_activities, :force => true do |t|
      t.references :user
      t.string     :remote_ip
      t.string     :report_name
      t.string     :format
      t.text       :params
      t.float      :elapsed_time
      t.timestamp  :created_at
    end
  end

  def self.down
    drop_table :report_activities
  end
end