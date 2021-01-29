class CreateM2mhubOpportunityOwner < ActiveRecord::Migration
  def up
    add_column :sales_opportunities, :owner_id, :integer
  end

  def down
    remove_column :sales_opportunities, :owner_id
  end
end