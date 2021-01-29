class CustomerCache
  def initialize
    @last_purchased = {}
  end    

  def sales_customer(erp_customer)
    if erp_customer
      self.sales_customers_by_erp_customer_id[erp_customer.id]
    else
      nil
    end
  end

  def sales_customers_by_erp_customer_id
    if @sales_customers_by_erp_customer_id.nil?      
      @sales_customers_by_erp_customer_id = {}
      Sales::Customer.where('erp_customer_id is not null').each do |sales_customer|
        @sales_customers_by_erp_customer_id[sales_customer.erp_customer_id.to_i] = sales_customer
      end
    end
    @sales_customers_by_erp_customer_id
  end

  def customer_last_purchased(part_number)
    if @last_purchased.member?(part_number)
      @last_purchased[part_number]
    else
      erp_customer = M2m::SalesOrderItem.where(fpartno: part_number).order(:finumber).last.try(:sales_order).try(:customer)
      @last_purchased[part_number] = erp_customer ? self.sales_customer(erp_customer) : nil
    end
  end

end