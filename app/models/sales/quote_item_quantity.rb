# == Schema Information
#
# Table name: sales_quote_item_quantities
#
#  id              :integer(4)      not null, primary key
#  quote_item_id   :integer(4)
#  price_method_id :integer(4)
#  quantity        :decimal(12, 2)
#  cost            :decimal(14, 4)
#  price           :decimal(14, 4)
#  created_at      :datetime
#  updated_at      :datetime
#

class Sales::QuoteItemQuantity < M2mhub::Base
  set_table_name 'sales_quote_item_quantities'
end
