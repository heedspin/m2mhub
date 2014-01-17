class M2mCustomers::SalesOrdersController < M2mhubController
  filter_access_to_defaults

  def index
    @customer = M2m::Customer.find(params[:m2m_customer_id])
    @sales_orders = M2m::SalesOrder.customer(@customer).includes(:releases, :items).paginate(:page => params[:page], :per_page => 10).order('forderdate desc, somast.fsono desc')
    # Optimizations:
    M2m::Item.attach_items(@sales_orders.map(&:items).to_a.flatten)
    @sales_orders.each do |so|
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
      so.items.each { |i| i.attach_releases_from_sales_order(so) }
    end    
  end
  
  protected

    def model_class
      M2m::SalesOrder
    end
end
