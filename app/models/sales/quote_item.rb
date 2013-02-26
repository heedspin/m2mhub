# == Schema Information
#
# Table name: sales_quote_items
#
#  id                   :integer          not null, primary key
#  quote_id             :integer
#  position             :integer
#  part_number          :string(255)
#  revision             :string(255)
#  display_id           :integer
#  description          :text
#  customer_part_number :string(255)
#  price_method_id      :integer
#  quantity             :decimal(12, 2)
#  expected_cost        :decimal(14, 2)
#  price                :decimal(14, 2)
#  created_at           :datetime
#  updated_at           :datetime
#

class Sales::QuoteItem < M2mhub::Base
  set_table_name 'sales_quote_items'
  def margin
    if @margin.nil?
      return nil unless (self.price.present? and (self.price > 0)) and (self.expected_cost.present?)
      @margin = (self.price - self.expected_cost) / self.price
    end
    @margin
  end
  
  def total_price
    (self.quantity || 0) * (self.price || 0)
  end
end
