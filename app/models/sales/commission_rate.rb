# == Schema Information
#
# Table name: commission_rates
#
#  id                    :integer          not null, primary key
#  customer_id           :integer
#  customer_name         :string(255)
#  customer_number       :string(255)
#  sales_person_id       :integer
#  sales_person_name     :string(255)
#  item_id               :integer
#  part_number           :string(255)
#  commission_percentage :decimal(12, 4)
#  created_at            :datetime
#  updated_at            :datetime
#

class Sales::CommissionRate < M2mhub::Base
  belongs_to :customer, :class_name => 'M2m::Customer'
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson'
  belongs_to :second_sales_person, :class_name => 'M2m::SalesPerson'
  belongs_to :item, :class_name => 'M2m::Item'
  validates_presence_of :sales_person
  validate :customer_or_item

  scope :by_salesperson_and_customer, -> { order(:sales_person_name, :customer_name, :part_number) }
  scope :sales_person, -> (sales_person_id) {
    where ['sales_person_id = ? or second_sales_person_id = ?', sales_person_id, sales_person_id]
  }
  scope :customer, -> (customer_id) {
    where :customer_id => customer_id
  }
  scope :item, -> (item_id) {
    where :item_id => item_id
  }

  def self.matching_item(item)
    where ['commission_rates.part_number like ?', self.get_base_part_number(item.part_number) + '%']
  end

  def revision
    # TODO: Add revision column.
    '000'
  end

  def base_part_number
    self.class.get_base_part_number(self.part_number)
  end
  def self.get_base_part_number(part_number)
    if part_number.nil?
      nil
    elsif part_number.strip =~ /^([A-Z]\d\d\d\d)[A-Z]$/
      $1
    else
      part_number
    end
  end

  protected

    before_validation :set_customer
    def set_customer
      if self.new_record? or self.customer_name_changed?
        if self.customer_name.present?
          if self.customer = M2m::Customer.name_like(self.customer_name).by_name.first
            self.customer_name = self.customer.name
            self.customer_number = self.customer.customer_number
          end
        else
          self.customer = self.customer_number = nil
        end
      end
      true
    end
    
    before_validation :set_item
    def set_item
      if self.new_record? or self.part_number_changed?
        if self.part_number.present?
          if self.item = M2m::Item.part_number_like(self.part_number).by_part_number.first
            self.part_number = self.item.part_number
          end
        else
          self.item = nil
        end
      end
      true
    end
    
    before_validation :set_sales_person_name
    def set_sales_person_name
      self.sales_person_name = self.sales_person.try(:name)
    end
    
    def customer_or_item
      if self.customer.blank? and self.item.blank?
        errors.add(:base, "Please choose a customer or item to apply the commission rate.")
      end
    end

end
