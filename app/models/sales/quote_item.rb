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
  
  def expected_cost=(val)
    val = val.gsub('$','') if val.is_a?(String)
    super(val)
  end

  attr_accessor :price_set_by_margin
  def price=(val)
    @price_set_by_margin = false
    if val.is_a?(String)
      if val.include?('%') and self.expected_cost.present?
        val = val.gsub('%', '').to_f
        val = (self.expected_cost.to_f / ((100 - val) / 100)).round(2)
        @price_set_by_margin = true
      else
        val = val.gsub('$','')
      end
    end
    super(val)
  end
  
  def total_price
    (self.quantity || 0) * (self.price || 0)
  end
end
