# == Schema Information
#
# Table name: customer_reports
#
#  id                 :integer          not null, primary key
#  customer_number    :string(255)
#  total_quote_amount :decimal(12, 2)
#  total_sales_amount :decimal(12, 2)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'csv'

class Sales::CustomerReport < M2mhub::Base
  self.table_name = 'customer_reports'
  belongs_to :customer, :class_name => 'M2m::Customer', :primary_key => 'fcustno', :foreign_key => :customer_number

  # Sales::CustomerReport.run
  def self.run
    reports = {}
    all.each do |r| 
      r.total_quote_amount = r.total_sales_amount = 0.0
      reports[r.customer_number] = r
    end
    customers = {}
    M2m::Customer.all.each { |c| customers[c.customer_number] = c }
    get_report = Proc.new do |customer_number|
      if result = reports[customer_number]
        result
      else
        reports[customer_number] = Sales::CustomerReport.new(:customer_number => customer_number, :total_quote_amount => 0.0, :total_sales_amount => 0.0)
      end
    end
    
    # Total Quotes
    results = M2m::Quote.connection.select_rows <<-SQL
      select qtmast.fcustno, qtitem.fpartno, max(qtitem.funetprice * qtitem.festqty)
      from qtitem left join qtmast on qtitem.fquoteno = qtmast.fquoteno
      group by qtmast.fcustno, qtitem.fpartno
    SQL
    results.each do |customer_number, part_number, total_price|
      get_report.call(customer_number).total_quote_amount += total_price
    end
    
    # Total Sales
    results = M2m::SalesOrderItem.connection.select_rows <<-SQL
      select somast.fcustno, sum(sorels.fnetprice)
      from sorels left join somast on sorels.fsono = somast.fsono
      where somast.fstatus = 'Closed'
      group by somast.fcustno
    SQL
    results.each do |customer_number, total_sales|
      get_report.call(customer_number).total_sales_amount += total_sales
    end
    
    reports.values.each(&:save!)
    true
  end
  
  # Sales::CustomerReport.to_csv(File.join(Rails.root, 'customer_reports.csv'))
  def self.to_csv(path)
    CSV.open(path, 'wb') do |csv|
      csv << ['Customer', 'Created Date', 'Created Month', 'Has Rep', 'Rep Name', 'Total Quotes', 'Total Sales']
      all(:include => { :customer => :sales_person}).each do |r|
        row = []
        row.push r.customer.company_name
        row.push r.customer.created_date.to_s(:database)
        row.push r.customer.created_date.beginning_of_month.to_s(:database)
        row.push r.customer.sales_person.present? ? 1 : 0
        row.push r.customer.sales_person.present? ? r.customer.sales_person.name : ''
        row.push r.total_quote_amount
        row.push r.total_sales_amount
        csv << row
      end
    end
  end
end
