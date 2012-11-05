# == Schema Information
#
# Table name: sales_quotes
#
#  id              :integer(4)      not null, primary key
#  quote_number    :string(255)
#  customer_name   :string(255)
#  customer_id     :integer(4)
#  contact_id      :integer(4)
#  recipient       :text
#  terms_id        :integer(4)
#  foreword        :text
#  postfix         :text
#  quote_state_id  :integer(4)
#  creator_id      :integer(4)
#  approver_id     :integer(4)
#  min_quote_price :decimal(12, 2)
#  max_quote_price :decimal(12, 2)
#  private_notes   :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Sales::Quote < M2mhub::Base
  set_table_name 'sales_quotes'
end
