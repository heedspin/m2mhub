class Customers::SalesBacklogReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @customer = parent_object
    @releases = M2m::SalesOrderRelease.filtered.status_open.not_filled.customer(@customer).includes(:sales_order => :customer).by_due_date.to_a
    sales_order_items = M2m::SalesOrderItem.for_releases(@releases).to_a
    M2m::SalesOrderItem.attach_to_releases_for_backlog(@releases, sales_order_items)
    items = M2m::Item.attach_items(sales_order_items)
    # This will get too many locations, but will be filtered with revision by InventoryLocation.attach_to_items.
    locations = M2m::InventoryLocation.with_part_numbers(items.map(&:part_number)).to_a
    M2m::InventoryLocation.attach_to_items(locations, items)
  end

  protected

    def model_class
      M2m::Customer
    end

    def parent_object
      @parent_object ||= M2m::Customer.find(params[:customer_id])
    end

end
