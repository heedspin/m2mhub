class CreateM2mhubContextComments < ActiveRecord::Migration
  def up
    create_table :context_groups, :force => true do |t|
      t.references :group_type
      t.string :name
      t.string :domain
      t.timestamps
    end
    create_table :context_group_users, :force => true do |t|
      t.references :user
      t.references :group
      t.timestamps
    end
    create_table :context_group_contexts, :force => true do |t|
      t.references :group
      t.references :context
      t.references :permission
      t.timestamps
    end
    create_table :contexts, :force => true do |t|
      t.string :key
      t.string :subject
      t.timestamps
    end
    create_table :context_comments, :force => true do |t|      
      t.references :context
      t.text :text
      t.integer :creator_id
      t.timestamps
      t.boolean :deleted
    end
  end

  def down
    drop_table :context_group_users
    drop_table :context_group_contexts
    drop_table :context_groups
    drop_table :contexts
    drop_table :context_comments
  end
end
