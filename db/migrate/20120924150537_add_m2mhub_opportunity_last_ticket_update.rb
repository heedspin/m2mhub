class AddM2mhubOpportunityLastTicketUpdate < ActiveRecord::Migration
  def up
    add_column :sales_opportunities, :last_comment_updated_id, :integer
  end

  def down
    remove_column :sales_opportunities, :last_comment_updated_id
  end
end