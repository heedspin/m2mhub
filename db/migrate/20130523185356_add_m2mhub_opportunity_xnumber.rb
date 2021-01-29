class AddM2mhubOpportunityXnumber < ActiveRecord::Migration
  def up
    add_column :sales_opportunities, :xnumber_decimal, :integer
  end

  def down
    remove_column :sales_opportunities, :xnumber_decimal
  end
end