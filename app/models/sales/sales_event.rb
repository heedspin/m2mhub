class Sales::SalesEvent

  def self.search(search)
    os = Sales::Opportunity.not_deleted.lead_level(Sales::LeadLevel::Search.open_lead).start_dates(search.start_date, search.end_date.advance(:days => 1))
    os = os.sales_territory(search.sales_territory_id) if search.sales_territory_id.present?
    os = os.owner(search.owner_id) if search.owner_id.present?
    os = os.rep_status(Sales::RepStatus.connected) if search.for_sales_rep
    events = os.all.map { |o| new(o) }

    cs = nil
    cs = Sales::OpportunityComment.not_deleted.lead_level(Sales::LeadLevel::Search.open_lead).notable.created(search.start_date, search.end_date.advance(:days => 1))
    cs = cs.status(search.status_id) if search.status_id.present?
    cs = cs.sales_territory(search.sales_territory_id) if search.sales_territory_id.present?
    cs = cs.owner(search.owner_id) if search.owner_id.present?
    cs = cs.rep_status(Sales::RepStatus.connected) if search.for_sales_rep
    events += cs.all.map { |c| new(c) }
    
    events
  end
  
  attr_accessor :object, :date, :amount, :type_name
  attr_accessor :customer, :source_name
  attr_accessor :opportunity
  attr_accessor :event_text, :event_url
  
  def initialize(thing)
    @object = thing
    if thing.is_a?(Sales::Opportunity)
      @opportunity = thing
      @date = @opportunity.start_date
      @type_name = 'New Opportunity'
    elsif thing.is_a?(Sales::OpportunityComment)
      comment = thing
      @opportunity = comment.opportunity
      @date = comment.created_at.to_date
      @customer = @opportunity.sales_customer
      @sales_rep_name = @customer.try(:sales_territory).try(:sales_rep_name)
      @sales_person_name = @opportunity.sales_person_name      
      if comment.comment_type.lost?
        @type_name = 'Lost Opportunity'
      elsif comment.comment_type.sales_order? and (sales_order_id = comment.sales_order_id).present?
        @type_name = 'Sales Order'
        @event_text = "SO #{sales_order_id}"
        @event_url = Rails.application.routes.url_helpers.sales_order_url(sales_order_id, :host => AppConfig.hostname)
      elsif comment.comment_type.quote? and (quote = comment.quote)
        @type_name = 'Quote'
        @event_text = "Quote #{quote.quote_number}"
        @event_url = Rails.application.routes.url_helpers.sales_quote_url(quote, :host => AppConfig.hostname)
      else
        @type_name = "Unknown comment #{comment.id}"
      end
    end
    
    @source_name = if @opportunity.source.try(:sales_rep?) and (sales_rep_name = @opportunity.sales_customer.try(:sales_territory).try(:sales_rep_name))
      "Rep: #{sales_rep_name}"
    elsif source_name = @opportunity.source.try(:name)
      "#{AppConfig.short_name}: #{source_name}"
    end
  end
  
  class Export
    include Plutolib::ToXls
    def initialize(events)
      @events = events
    end
    
    def xls_initialize
      xls_field("Date") { |e| e.date }
      xls_field("Type") { |e| e.type_name }
      xls_field('Customer') { |e| e.opportunity.sales_customer.try(:name) }
      xls_field('Opportunity') { |e| e.opportunity.number_and_title }
      xls_field('Event Info') { |e| e.event_text }
      xls_field('Source') { |e| e.opportunity.source.try(:name) }
      xls_field('Sales Rep') { |e| e.opportunity.sales_customer.try(:sales_territory).try(:sales_rep_name) }
      xls_field('Sales Person') { |e| e.opportunity.sales_person_name }
      xls_field('LXD Owner') { |e| e.opportunity.owner.try(:full_name) }
    end

    def all_data
      @events
    end
  end
end