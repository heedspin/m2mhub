class HomeController < ApplicationController
  def index
    yesterday = Date.current.advance(:days => -1)
    @user_activities = UserActivity.find(:all, :order => 'id desc', :limit => 10)
    @sales_orders = M2m::SalesOrder.since(yesterday).all
    # Optimization:
    @sales_orders.each do |so| 
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
    end
    @quotes = M2m::Quote.since(yesterday).all
  end
end