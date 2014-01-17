require 'plutolib/to_xls'

class Sales::FirstSaleReport
  include Plutolib::ToXls

  def xls_sheet_name
    'First Sale Report'
  end

  def xls_clean_string(txt)
    txt.try :tr, "\x91-\x94\x9c\x9d\x80", "''\"\"\"\"'"
  end

  def xls_initialize
    xls_field('Customer') { |d| d.sales_order.customer_name }
    xls_field('Order Date') { |d| d.sales_order.order_date }
    xls_field('Sales Order') { |d| d.sales_order.order_number }
    xls_field('Part Number') { |d| d.sales_order_item.part_number }
    xls_field('Product Class') { |d| d.sales_order_item.item.try(:product_class).try(:name) }
    xls_field('Quantity') { |d| d.releases.sum(&:order_quantity) }
    xls_field('Total Price', self.xls_dollar_format) { |d|
      d.releases.sum(&:total_price)
    }
  end

  FirstSaleData = Struct.new(:sales_order, :sales_order_item, :releases)

  def xls_data
    result = []
    results = M2m::SalesOrderItem.connection.select_rows <<-SQL
      select somast.fcustno as customer_number,
      	min(somast.forderdate) as order_date,
      	soitem.fpartno as part_number
      from somast
      left join soitem on somast.fsono = soitem.fsono
      where soitem.fquantity >= 100
        and somast.fstatus != 'CANCELLED'
      group by somast.fcustno, soitem.fpartno
      order by order_date desc, customer_number, part_number
    SQL
    already_ordered = Set.new
    results.each do |customer_number, order_date, part_number|
      key = if part_number.strip =~ /^([A-Z]\d\d\d\d)[A-Z]$/
        [customer_number, $1]
      else
        [customer_number, part_number]
      end
      next if already_ordered.member?(key)
      already_ordered.add(key)
      if soi = M2m::SalesOrderItem.customer(customer_number).order_date(order_date).where(:fpartno => part_number).first
        releases = soi.sales_order.releases.for_part_number(soi.part_number).all
        result.push FirstSaleData.new(soi.sales_order, soi, releases)
      end
    end    
    result
  end
end
