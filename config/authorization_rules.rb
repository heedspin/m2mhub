authorization do
  
  role :guest do
  end
  
  role :doogle_admin do
    # TODO: factor this out or make configurable.
    has_permission_on :doogle_displays, :to => [:manage, :next_model_number]
    has_permission_on :doogle_display_logs, :to => :read
  end

  role :shipping do
    includes :doogle_admin
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
    has_permission_on :m2mhub_triggers, :to => :manage
    has_permission_on :m2mhub_events, :to => :manage
  end

  role :sales do
    includes :shipping
    has_permission_on :quotes, :to => :manage
    has_permission_on :sales_orders, :to => :read
    has_permission_on :sales_order_items, :to => :read
    has_permission_on :customers_sales_orders, :to => :read
    has_permission_on :customers, :to => :manage
    has_permission_on :customers_quotes, :to => :read
    has_permission_on :customers_contacts, :to => :manage
    has_permission_on :customers_invoiced_sales_reports, :to => :manage
    has_permission_on :customers_sales_backlog_reports, :to => :manage
    has_permission_on :items_sales_order_releases, :to => :read
    has_permission_on :items_quote_items, :to => :read
    has_permission_on :items_purchase_order_items, :to => :read
    has_permission_on :items_boms, :to => :read
    has_permission_on :items_bom_parents, :to => :read
    has_permission_on :items_bom_children, :to => :read
    has_permission_on :quality_quality_dashboard, :to => :read
    has_permission_on :quality_customer_otd_reports, :to => :make
    has_permission_on :quality_rma_reports, :to => :make
    has_permission_on :quality_credit_memo_reports, :to => :make
    has_permission_on :quality_rmas, :to => :read
    has_permission_on :quality_rma_lighthouse_tickets, :to => :create
    has_permission_on :invoiced_sales_reports, :to => :manage
    has_permission_on :pro_forma_sales_reports, :to => :manage
    has_permission_on :sales_commission_rates, :to => :manage
    has_permission_on :sales_commission_reports, :to => :manage
    has_permission_on :sales_reports, :to => :read
  end
  
  role :production do
    has_permission_on :production_production_dashboard, :to => :read
    has_permission_on :production_work_center_load_reports, :to => :make
    has_permission_on :production_inventory_reports, :to => :read
    has_permission_on :production_inventory_reports_customer_reports, :to => :read
    has_permission_on :production_inventory_reports_obsolete_reports, :to => :read
    has_permission_on :production_purchase_queue_summaries, :to => :read
    has_permission_on :production_purchase_queue_details, :to => :read
    has_permission_on :production_purchase_queue_notes, :to => :manage
  end
  
  role :manager do
    includes :shipping, :sales, :production
    has_permission_on :production_labor_reports, :to => :read
  end

  role :admin do
    includes :manager
    has_permission_on :users_password, :to => [:manage, :update_without_current_password]
    has_permission_on :users, :to => [:manage, :set_role, :switch, :verify, :delete, :message]
    has_permission_on :user_activities, :to => :manage
    has_permission_on :production_inventory_reports, :to => :manage
  end
end
 
privileges do
  privilege :manage, :includes => [:make, :read, :update, :destroy, :move, :fix_positions]
  privilege :read, :includes => [:index, :show]
  privilege :make, :includes => [:new, :create, :thanks]
  privilege :update, :includes => :edit
  privilege :set_role
end