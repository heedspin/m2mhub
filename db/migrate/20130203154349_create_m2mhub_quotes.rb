class CreateM2mhubQuotes < ActiveRecord::Migration
  def up
    create_table :sales_quotes, :force => true do |t|
      t.integer :quote_number
      t.date :date
      t.string :customer_name
      t.references :customer
      t.text :recipient
      t.references :terms
      t.string :other_terms
      t.text :foreword
      t.text :postfix
      t.references :quote_status
      t.integer :creator_id
      t.integer :approver_id
      t.decimal :min_quote_price, :precision => 12, :scale => 2
      t.decimal :max_quote_price, :precision => 12, :scale => 2
      t.text :private_notes
      t.timestamps
    end
    
    create_table :sales_quote_items, :force => true do |t|
      t.references :quote
      t.integer :position
      t.string :part_number
      t.string :revision
      t.references :display
      t.text :description
      t.string :customer_part_number
      t.references :price_method # fixed vs unit vs hourly...
      t.decimal :quantity, :precision => 12, :scale => 2
      t.decimal :expected_cost, :precision => 14, :scale => 2
      t.decimal :price, :precision => 14, :scale => 2
      t.timestamps
    end    
  end

  def down
    drop_table :sales_quote_items
    drop_table :sales_quotes
  end
end
