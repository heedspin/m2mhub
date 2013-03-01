class AlterM2mhubOpportunityCommentQuoteToInteger < ActiveRecord::Migration
  def up
    change_column :sales_opportunity_comments, :quote_id, :integer
  end

  def down
    change_column :sales_opportunity_comments, :quote_id, :string
  end
end