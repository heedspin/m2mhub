class SalesBacklogReportsController < ApplicationController
  filter_access_to_defaults

  def index
    # SalesBacklogReport.paginate(:all, :page => params[:page], :per_page => 50, :order => 'created_at desc')
    @due_date ||= (d = Date.current) && d.advance(:days => (d.wday <= 5 ? 5 - d.wday : 6))
    @releases = M2m::SalesOrderRelease.filtered.open.not_filled.due_by(@due_date).all(:include => {:sales_order => :sales_customer_master}, :order => 'somast.fcompany, sorels.fpartno')
  end

end
