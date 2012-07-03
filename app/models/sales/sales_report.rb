# == Schema Information
#
# Table name: sales_reports
#
#  id                    :integer(4)      not null, primary key
#  report_time_period_id :integer(4)
#  date                  :date
#  data                  :text
#  period_invoiced_sales :decimal(12, 2)
#  period_bookings       :decimal(12, 2)
#  created_at            :datetime
#  updated_at            :datetime
#

class Sales::SalesReport < ApplicationModel
  set_table_name 'sales_reports'
  belongs_to_active_hash :report_time_period
  scope :for_date, lambda { |date|
    {
      :conditions => { :date => date }
    }
  }
  
  def run(previous_sales_report)
    
    M2m::Invoice.not_void.for_date(self.date).each do |invoice|
      self.data[]
    end
  end
  
  def data
    if @data.nil?
      if x = self.read_attribute(:data)
        @data = ActiveSupport::JSON.decode(x)
      else
        @data = Hash.new(0)
      end
    end
    @data
  end
  
  protected    
  
    before_save :serialize_data
    def serialize_data
      self.write_attribute(:data, self.data.to_json)
    end
end
