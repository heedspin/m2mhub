authorization do
  
  role :guest do
  end

  role :shipping do
    has_permission_on [:users, :passwords], :to => [:show,:update,:destroy] do
      if_attribute :id => is {user.id}
    end
    if !Rails.env.production?
      has_permission_on :users, :to => :switch
    end
    has_permission_on :items, :to => :read
    has_permission_on :user_activities, :to => :read
    has_permission_on :customers, :to => :read
    has_permission_on :shipping_shipping_dashboard, :to => :read
    has_permission_on :shipping_shippers, :to => :read
    has_permission_on :shipping_receivers, :to => :read
    has_permission_on :sales_backlog_reports, :to => :manage
    has_permission_on :sales_order_releases, :to => :read
    has_permission_on :quote_items, :to => :read
    has_permission_on :items_history, :to => :read
    has_permission_on :items_shippers, :to => :read
    has_permission_on :items_jobs, :to => :read
  end

  role :sales do
    includes :shipping
    has_permission_on :quotes, :to => :read
    has_permission_on :sales_orders, :to => :read
    has_permission_on :sales_order_items, :to => :read
    has_permission_on :customers_sales_orders, :to => :read
    has_permission_on :customers_quotes, :to => :read
    has_permission_on :items_sales_order_releases, :to => :read
    has_permission_on :items_quote_items, :to => :read
    has_permission_on :items_purchase_order_items, :to => :read
    has_permission_on :quality_quality_dashboard, :to => :read
    has_permission_on :quality_customer_otd_reports, :to => :make
    has_permission_on :quality_rma_reports, :to => :make
    has_permission_on :quality_credit_memo_reports, :to => :make
    has_permission_on :quality_customer_service_logs, :to => :read
  end

  role :admin do
    includes :shipping, :sales
    has_permission_on :users_password, :to => [:manage, :update_without_current_password]
    has_permission_on :users, :to => [:manage, :set_role, :switch, :verify, :delete, :message]
    has_permission_on :content_modules, :to => :manage
    has_permission_on :user_activities, :to => :manage
  end
end
 
privileges do
  privilege :manage, :includes => [:make, :read, :update, :destroy, :move, :fix_positions]
  privilege :read, :includes => [:index, :show]
  privilege :make, :includes => [:new, :create, :thanks]
  privilege :update, :includes => :edit
  privilege :set_role
end