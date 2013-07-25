class CreateM2mhubInspectionTasks < ActiveRecord::Migration
  def up
    create_table :inspection_tasks, :force => true do |t|
      t.string :part_number
      t.string :revision
      t.decimal :quantity, :precision => 14, :scale => 4
      t.string :title
      t.text :body
      t.integer :task_type_id
      t.string :purchase_order_number
      t.string :purchase_order_item_number
      t.string :purchase_order_item_id
      t.integer :rma_number
      t.string :rma_item_number
      t.string :rma_item_id
      t.string :rma_customer_name
      t.datetime :date_expected
      t.string :last_receiver_id
      t.integer :status_id
      t.string :lighthouse_ticket_id
      t.string :lighthouse_project_id
      t.string :lighthouse_project_name
      t.string :lighthouse_milestone
      t.string :lighthouse_status
      t.boolean :lighthouse_closed
      t.string :lighthouse_url
      t.string :lighthouse_title
      t.text :lighthouse_last_comment
      t.datetime :lighthouse_last_updated_at
      t.string :lighthouse_last_updater
      t.string :lighthouse_last_assigned_user_name      
      t.timestamps
    end
  end

  def down
    drop_table :inspection_tasks
  end
end