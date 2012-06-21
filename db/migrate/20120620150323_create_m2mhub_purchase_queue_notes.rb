class CreateM2mhubPurchaseQueueNotes < ActiveRecord::Migration
  def up
    create_table :purchase_queue_notes, :force => true do |t|
      t.references :item
      t.string :part_number
      t.string :revision
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_queue_notes
  end
end