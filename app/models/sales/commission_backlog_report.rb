require 'plutolib/to_xls'

class Sales::CommissionBacklogReport
  include Plutolib::ToXls

  def initialize(args)
  end
  
  def xls_filename
    'commission_backlog'
  end

  def xls_sheet_name
    'Commission Backlog'
  end

  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    xls_field('Due Date') { |cd| cd.release.due_date }
    xls_field('Sales Order Number') { |cd| cd.release.sales_order_number }
    xls_field("#{AppConfig.short_name} Part Number") { |cd| cd.release.part_number }
    xls_field('Part Description') { |cd| cd.release.item.try(:description) }
    xls_field('Order Quantity') { |cd| cd.release.quantity }
    xls_field('Shipped Quantity') { |cd| cd.release.quantity_shipped }
    xls_field('Backlog Quantity') { |cd| cd.release.backorder_quantity }
    xls_field('Unit Price', dollar_format) { |cd|
      cd.release.unit_price.to_f.round(2)
    }
    xls_field('Backlog Price', dollar_format) { |cd|
      (cd.release.unit_price * cd.release.backorder_quantity).to_f.round(2)
    }
    xls_field('Customer Name') { |cd| cd.release.sales_order.customer.name }
    xls_field('Sales Rep') { |cd| cd.sales_person_name }
    xls_field('Commission Rate') { |cd|
      cd.commission_percentage.present? ? (cd.commission_percentage / 100).to_f.round(2) : 0.0
    }
    xls_field('Commission Backlog', dollar_format) { |cd|
      backlog_price = (cd.release.unit_price * cd.release.backorder_quantity).to_f.round(2)
      cd.commission_percentage.present? ? ((cd.commission_percentage / 100) * backlog_price).to_f.round(2) : 0.0
    }
  end

  CommissionData = Struct.new(:release, :sales_person_name, :commission_percentage)

  def xls_data
    @backlog_report = Sales::BacklogReport.by_date_desc.first
    @finder = Sales::CommissionRateFinder.new
    @backlog_report.releases.map do |release|
      name, percentage, reason = @finder.get_rate( :customer => release.sales_order.customer,
                                                   :part_number => release.part_number,
                                                   :revision => release.revision,
                                                   :sales_order => release.sales_order )
      CommissionData.new(release, name, percentage)
    end
  end
end