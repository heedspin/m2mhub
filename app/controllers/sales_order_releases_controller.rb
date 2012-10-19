class SalesOrderReleasesController < M2mhubController
  filter_access_to_defaults

  class SearchItem < M2m::SalesOrderRelease
    set_primary_key :_disabled
    attr_accessor :filter_status
  end

  def index
    @search = SearchItem.new(:fpartno => params[:item], :filter_status => params[:status])
    @sales_order_releases = M2m::SalesOrderRelease.for_part_number(@search.part_number).by_due_date_desc
    if @search.filter_status.present?
      @sales_order_releases = @sales_order_releases.with_status(@search.filter_status)
    end
    @sales_order_releases = @sales_order_releases.all(:include => [:sales_order])
    @sales_order_items = M2m::SalesOrderItem.for_item(@search.part_number).all(:include => :item)
    # OPTIMIZATION: eager load
    @sales_order_releases.each do |r|
      if i = @sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
        r.item = i
      end
    end
    render :action => 'index', :layout => false
  end

end
