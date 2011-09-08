class AddContentModuleMetaTitle < ActiveRecord::Migration
  def self.up
    add_column :content_modules, :meta_title, :string
    add_column :content_modules, :has_meta_title, :boolean
    execute "update content_modules set has_meta_title = has_meta_description"
  end

  def self.down
    remove_column :content_modules, :has_meta_title
    remove_column :content_modules, :meta_title
  end
end