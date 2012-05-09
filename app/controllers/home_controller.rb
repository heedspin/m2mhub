class HomeController < M2mhubController
  def index
    yesterday = Date.current.advance(:days => -1)
    if permitted_to?(:manage, :user_activities)
      @user_activities = UserActivity.by_date_desc.all(:limit => 10)
    else
      @user_activities = UserActivity.for_user(current_user).by_date_desc.all(:limit => 10)
    end
    @sales_orders = M2m::SalesOrder.since(yesterday).all
    # Optimization:
    @sales_orders.each do |so|
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
    end
    @quotes = M2m::Quote.since(yesterday).all
  end
end
