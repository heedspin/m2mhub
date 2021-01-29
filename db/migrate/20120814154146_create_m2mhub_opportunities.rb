class CreateM2mhubOpportunities < ActiveRecord::Migration
  def up
    create_table :sales_opportunities, :force => true do |t|
      t.date :start_date
      t.date :end_date
      t.string :customer_id
      t.string :customer_name
      t.integer :amount
      t.references :opportunity_source
      t.string :product
      t.string :title
      t.text :body
      t.string :sales_person_id
      t.string :sales_person_name
      t.integer :status_id
      t.date :wakeup
      t.timestamps
      t.references :creator
    end
    
    create_table :sales_opportunity_comments, :force => true do |t|
      t.references :opportunity
      t.integer :comment_type_id
      t.integer :status_id
      t.integer :previous_status_id
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
      t.string :sales_order_id
      t.string :quote_id
      t.date :date
      t.integer :loss_reason_id
      t.date :wakeup
      t.text :comment
      t.timestamps
      t.references :creator
    end
  end

  def down
    drop_table :sales_opportunity_comments
    drop_table :sales_opportunities
  end
end