# == Schema Information
#
# Table name: sales_quote_items
#
#  id                   :integer(4)      not null, primary key
#  quote_id             :integer(4)
#  position             :integer(4)
#  item_type_id         :integer(4)
#  item_id              :integer(4)
#  part_number          :string(255)
#  customer_part_number :string(255)
#  description          :text
#

class Sales::QuoteItem < M2mhub::Base
  set_table_name 'sales_quote_items'
end
