class ItemsController < ApplicationController
  filter_access_to_defaults

  class SearchItem < M2m::Item
    # Allows search[:fpartno] to be mass-assigned.
    set_primary_keys '_disabled_fpartno', '_disabled_frev'
  end

  def index
    @search_item = SearchItem.new(params[:search])
    if @search_item.fpartno.present?
      @items = M2m::Item.part_number_like(@search_item.fpartno).paginate(:all, :page => params[:page],
                                                                         :per_page => 20,
                                                                         :order => 'inmast.fpartno',
                                                                         :include => :vendors)
    end
  end

  def show
    @item = current_object
    @sales_order_items = @item.sales_order_items.all(:order => 'soitem.fsono desc, soitem.fenumber', :include => :sales_order)
    @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).all#(:include => [:sales_order, :item])
    @sales_order_releases.each do |r|
      if i = @sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
        r.item = i
        r.sales_order = i.sales_order
      end
    end
    @purchase_order_items = @item.purchase_order_items.all(:include => :purchase_order)
    @purchase_order_items = @purchase_order_items.sort_by { |i| i.last_promise_date }.reverse
    @shippers = M2m::Shipper.for_item(@item).all(:order => 'shmast.fshipdate desc')
    @material_availability_report = MaterialAvailabilityReport.new( @item,
                                                                    @sales_order_releases,
                                                                    @purchase_order_items )
  end

  protected

    def model_class
      M2m::Item
    end

end
