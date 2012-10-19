class AddM2mhubEventTicketUrl < ActiveRecord::Migration
  def up
    add_column :m2mhub_events, :ticket_url, :string
    rename_column :m2mhub_events, :status, :ticket_status
    add_column :m2mhub_events, :body, :text
    rename_column :m2mhub_events, :m2mhub_summary, :title
  end

  def down
    rename_column :m2mhub_events, :title, :m2mhub_summary
    remove_column :m2mhub_events, :body
    rename_column :m2mhub_events, :ticket_status, :status
    remove_column :m2mhub_events, :ticket_url
  end
end