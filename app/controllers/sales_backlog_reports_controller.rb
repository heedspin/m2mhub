class SalesBacklogReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @search_performed = params.member?(:search)
    @search = SalesBacklogReport.new(params[:search])
    @search.due_date ||= Date.current.next_week

    if @search_performed
      @releases = M2m::SalesOrderRelease.filtered.open.not_filled.due_by(@search.due_date).all(:include => {:sales_order => :customer}, :order => 'somast.fcompany, sorels.fsono, sorels.fpartno')
      # Filter out by fob and status
      @releases = @releases.select do |r|
        correct_group = @search.fob_group.nil? || @search.fob_group.member?(r.sales_order.fob)
        correct_status = @search.customer_status.nil? || (r.sales_order.customer.status == @search.customer_status)
        # debugger if Breakpoints.buc && (customer.fcstatus == 'H')
        correct_group && correct_status
      end
      if params[:commit] == 'Print'
        @title = "#{CompanyConfig.short_name} Backlog #{@search.due_date.to_s(:sales_date)}"
        @filename = [CompanyConfig.short_name.downcase, 'backlog', @search.due_date.strftime("%m_%d_%y")].join('_') + '.pdf'
        render_pdf :action => 'show.pdf.prince', :filename => @filename, :layout => false
      end
    end
  end

end
