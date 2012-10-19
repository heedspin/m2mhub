class CreateM2mhubEvents < ActiveRecord::Migration
  def up
    add_column :users, :lighthouse_user_id, :string
    create_table :m2mhub_triggers, :force => true do |t|
      t.references :trigger_type
      t.references :trigger_state
      t.string :part_number
      t.references :notification_type
      t.integer :target_user_id
      t.string :lighthouse_project_id
      t.string :title
      t.text :instructions
      t.timestamps
    end
    create_table :m2mhub_events, :force => true do |t|
      t.references :trigger
      t.string :erp_type
      t.integer :erp_id
      t.string :erp_number
      t.string :lighthouse_ticket_id
      t.string :lighthouse_project_id
      t.string :m2mhub_summary
      t.references :user
      t.timestamps
    end
  end

  def self.down
    remove_column :users, :lighthouse_user_id
    drop_table :m2mhub_events
    drop_table :m2mhub_triggers
  end
end