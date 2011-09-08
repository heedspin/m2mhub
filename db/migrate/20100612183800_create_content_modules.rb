class CreateContentModules < ActiveRecord::Migration
  def self.up
    create_table :content_modules, :force => true do |t|
      t.string :key
      t.string :description
      t.boolean :has_title
      t.string :title
      t.boolean :has_content
      t.text :content
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.boolean :has_image
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.boolean :has_attachment
      t.text :meta_description
      t.boolean :has_meta_description
      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :content_modules
  end
end
