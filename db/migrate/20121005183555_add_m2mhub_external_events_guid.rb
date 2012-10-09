class AddM2mhubExternalEventsGuid < ActiveRecord::Migration
  def up
    add_column :m2mhub_external_events, :guid, :string
  end

  def down
    remove_column :m2mhub_external_events, :guid
  end
end
