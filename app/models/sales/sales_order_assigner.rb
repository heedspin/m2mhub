require 'plutolib/stateless_delayed_report'

class Sales::SalesOrderAssigner
  include Plutolib::StatelessDelayedReport
  def initialize(args={})
    @start_date = args[:start_date] || Date.current.advance(:months => -1)
    @start_date = DateParser.parse(@start_date) if @start_date.is_a?(String)
    @dry_run = false
  end
  # Sales::SalesOrderAssigner.new.run_report
  def run_report
    M2m::SalesOrder.ordered_since(@start_date).includes(:customer).by_order_date.each do |sales_order|
      if found = Sales::OpportunityComment.not_deleted.sales_orders.where(:sales_order_id => sales_order.order_number).first
        # Already assigned
      elsif sales_customer = Sales::Customer.erp_customer(sales_order.customer.id).first
        part_numbers = sales_order.items.all.map(&:part_number)
        opportunities = sales_customer.opportunities.not_deleted.by_last_update_desc.all
        if opportunity = opportunities.detect { |o| (o.all_referenced_part_numbers & part_numbers).size > 0 }
          comment = opportunity.comments.build
          comment.date = sales_order.order_date
          comment.comment_type = Sales::OpportunityCommentType.sales_order
          comment.status = opportunity.status
          comment.sales_order_id = sales_order.order_number
          comment.creator_id = User.where(:email => AppConfig.email_address).first.try(:id)
          comment.win_type = if part_numbers.any? { |pn| pn == 'NRE CHARGE' }
            Sales::OpportunityWinType.tooling_order
          elsif sales_order.total_price < 1000
            Sales::OpportunityWinType.sample_order
          else
            Sales::OpportunityWinType.production_order
          end
          prefix = @dry_run ? 'Dry Run: ' : ''
          log "#{prefix}SO #{sales_order.order_number} => #{comment.win_type} - #{opportunity.sales_customer_name}: #{opportunity.number_and_title}"          
          comment.save unless @dry_run
        elsif opportunities.size > 0
          log "No matching opportunity for #{sales_customer.name}, SO #{sales_order.order_number}"
        else
          log "No opportunities for sales customer #{sales_customer.name}, SO #{sales_order.order_number}"
        end
      else
        log "No sales customer for erp customer #{sales_order.customer_name}, SO #{sales_order.order_number}"
      end
    end
    true
  end
end
