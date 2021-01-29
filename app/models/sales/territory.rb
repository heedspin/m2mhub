# == Schema Information
#
# Table name: sales_territories
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  sales_rep_name :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  erp_vendor_id  :string(255)
#

class Sales::Territory < M2mhub::Base
  self.table_name = 'sales_territories'
  scope :by_name, -> { order('name') }
  belongs_to :vendor, :class_name => M2m::Vendor, :foreign_key => 'erp_vendor_id', :primary_key => 'fvendno'

  def sales_rep_name
    self.vendor.try(:name)
  end
  
  def self.by_sales_rep_or_name
    all.sort_by { |t| [t.sales_rep_name.present? ? t.sales_rep_name : 'ZZZZZZZZZZZZZZZZZZ', t.name ] }
  end

  def name_and_description
    @name_and_description ||= [name, description].select(&:present?).join( ' - ')
  end
  
  def rep_and_description
    @rep_and_description ||= [sales_rep_name.present? ? sales_rep_name : name, description.present? ? description : (sales_rep_name.present? ? name : nil)].select(&:present?).join( ' - ')
  end

  def name_and_sales_rep
    @name_and_sales_rep ||= [name, sales_rep_name].select(&:present?).join( ' - ')
  end
  
  def sales_rep_or_name
    @sales_rep_or_name ||= self.sales_rep_name.present? ? self.sales_rep_name : "No Rep: #{self.name}"
  end
end
