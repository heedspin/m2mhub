class M2mhubCreateInventoryReports < ActiveRecord::Migration
  def up
    create_table :inventory_reports, :force => true do |t|
      t.references :delayed_job
      t.references :delayed_job_status
      t.text :delayed_job_log
      t.timestamps
      t.references :inventory_report_cost_method
      t.float :total_on_hand_cost
      t.float :total_on_order_cost
      t.float :total_available_cost
      t.float :total_committed_cost
    end
    
    create_table :inventory_report_items, :force => true do |t|
      t.references :inventory_report
      t.references :inventory_report_customer
      t.string :part_number
      t.string :revision
      t.integer :m2m_identity_column
      t.float :quantity_on_hand
      t.float :quantity_committed
      t.float :quantity_available
      t.float :quantity_on_order
      t.references :inventory_report_cost_method
      t.float :cost
    end
    
    create_table :inventory_report_customers, :force => true do |t|
      t.references :inventory_report
      t.string :customer_name
      t.string :customer_number
      t.integer :m2m_identity_column
      t.float :total_on_hand_cost
      t.float :total_on_order_cost
      t.float :total_available_cost
      t.float :total_committed_cost
    end
  end

  def down
  end
end