require 'plutolib/logger_utils'

class Sales::ErpCustomerMatcher
  include Plutolib::LoggerUtils
  def initialize
    @dry_run = false
  end
  # Sales::ErpCustomerMatcher.new.run_report
  def run_report
    @already_matched = 
      Sales::Customer.connection.select_rows('select distinct(erp_customer_id) from sales_customers').select(&:present?).map { |x| M2m::Customer.pad_customer_number(x.first) }
    @unmatched_erp = 
      M2m::Customer.select('[slcdpmx].[identity_column], [slcdpmx].[fcustno], [slcdpmx].[fcompany]').where(['[slcdpmx].[identity_column] not in (?)', @already_matched]).to_a
    log "Found #{@unmatched_erp.size} customer records."
    if @unmatched_erp.size > 0
      Sales::Customer.where('erp_customer_id = \'\' or erp_customer_id is null').each do |sales_customer|
        if match = Amatcher.find_similar( :match => sales_customer.name, :method => :company_name,
                                           :objects => @unmatched_erp,
                                           :limit => 1, :threshold => 0.76 ).first
          match_name = match.object.company_name.upcase
          erp_customer = @unmatched_erp.detect { |c| c.company_name.upcase == match_name }
          @unmatched_erp.delete_if { |c| c.company_name.upcase == match_name }
          prefix = @dry_run ? 'Dry Run: ' : ''
          unless @dry_run
            sales_customer.update_attributes(:erp_customer_id => erp_customer.id)
          end
          log "#{prefix}#{sales_customer.name} <= (#{match.weight}) #{erp_customer.customer_number} #{erp_customer.company_name.strip}"
        else
          # log "No match for sales customer #{sales_customer.name}"
        end
      end
    end
    true
  end
end
