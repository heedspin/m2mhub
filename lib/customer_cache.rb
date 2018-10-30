class CustomerCache
  def sales_customer(erp_customer)
    if erp_customer
      self.sales_customers_by_erp_customer_id[erp_customer.fcustno.to_i]
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
end