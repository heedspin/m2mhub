require 'plutolib/to_xls'

class M2mCustomer::Export
  include Plutolib::ToXls
  
  def xls_filename
    Time.now.strftime("%y%m%d") + '_' + AppConfig.short_name + '_Customers'
  end
  
  def xls_sheet_name
    'Customers'
  end
  
  def xls_initialize
  	xls_field('Customer Number') { |c| c.customer_number }
    xls_field('Customer Name') { |c| c.company_name }
    xls_field('Sold To City') { |c| 
      c.addresses.select { |a| a.sold_to? && a.work_city.present? }.map { |a| a.work_city.strip }.uniq.sort.join(', ')
    }
    xls_field('Sold To State') { |c| 
      c.addresses.select { |a| a.sold_to? && a.work_state.present? }.map { |a| a.work_state.strip }.uniq.sort.join(', ')
    }
    xls_field('Ship To City') { |c|
      c.addresses.select { |a| a.ship_to? && a.work_city.present? }.map { |a| a.work_city.strip }.uniq.sort.join(', ')
    }
    xls_field('Ship To State') { |c|
      c.addresses.select { |a| a.ship_to? && a.work_state.present? }.map { |a| a.work_state.strip }.uniq.sort.join(', ')
    }
    xls_field('Rep Assignment') { |c| c.sales_person.try(:name) }
  end  
  
  def all_data
    M2m::Customer.includes(:addresses).includes(:sales_person).all
  end

end
