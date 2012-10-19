class AddM2mhubEventStatus < ActiveRecord::Migration
  def up
    add_column :m2mhub_events, :status, :string
    add_column :m2mhub_events, :closed, :boolean
  end

  def down
    remove_column :m2mhub_events, :status
    remove_column :m2mhub_events, :closed
  end
end