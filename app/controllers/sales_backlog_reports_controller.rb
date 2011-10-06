class SalesBacklogReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @search = SalesBacklogReport.new(params[:search])
    # Set to Friday by default
    @search.due_date ||= (today = Date.current) && today.advance(:days => (today.wday <= 5 ? 5 - today.wday : 6))

    @releases = M2m::SalesOrderRelease.filtered.open.not_filled.due_by(@search.due_date).all(:include => {:sales_order => :sales_customer_master}, :order => 'somast.fcompany, sorels.fpartno')
  end

end
