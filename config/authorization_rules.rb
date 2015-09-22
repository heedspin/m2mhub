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
    has_permission_on :m2mhub_user_activities, :to => :read
    has_permission_on :customers, :to => :read
    has_permission_on :sales_order_releases, :to => :read
    has_permission_on :sales_quote_items, :to => :read
    has_permission_on :items_history, :to => :read
    has_permission_on :items_shippers, :to => :read
    has_permission_on :items_jobs, :to => :read
    has_permission_on :m2mhub_triggers, :to => :manage
    has_permission_on :m2mhub_events, :to => :manage
    has_permission_on :shipping_backlog_reports, :to => :manage
    has_permission_on :shipping_daily_reports, :to => :read
  end

  role :sales do
    includes :shipping
    has_permission_on :m2m_quotes, :to => :manage
    has_permission_on :sales_quotes, :to => :manage
    has_permission_on :sales_quote_items, :to => :manage
    has_permission_on :sales_orders, :to => :read
    has_permission_on :sales_order_items, :to => :read
    has_permission_on :customers_sales_orders, :to => :read
    has_permission_on :customers, :to => :manage
    has_permission_on :customers_quotes, :to => :read
    has_permission_on :customers_contacts, :to => :manage
    has_permission_on :customers_invoiced_sales_reports, :to => :manage
    has_permission_on :customers_sales_backlog_reports, :to => :manage
    has_permission_on :sales_customers, :to => :manage
    has_permission_on :sales_customers_opportunities, :to => :manage
    has_permission_on :sales_customers_quotes, :to => :manage
    has_permission_on :sales_territories, :to => :manage
    has_permission_on :parent_companies, :to => :manage
    has_permission_on :items_sales_order_releases, :to => :read
    has_permission_on :items_m2m_quote_items, :to => :read
    has_permission_on :items_purchase_order_items, :to => :read
    has_permission_on :items_boms, :to => :read
    has_permission_on :items_bom_parents, :to => :read
    has_permission_on :items_bom_children, :to => :read
    has_permission_on :quality_quality_dashboard, :to => :read
    has_permission_on :quality_customer_otd_reports, :to => :make
    has_permission_on :quality_rma_reports, :to => :make
    has_permission_on :quality_credit_memo_reports, :to => :make
    has_permission_on :quality_rmas, :to => :read
    has_permission_on :quality_inspection_tasks, :to => :manage
    has_permission_on :invoiced_sales_reports, :to => :manage
    has_permission_on :pro_forma_sales_reports, :to => :manage
    has_permission_on :sales_commission_rates, :to => :manage
    has_permission_on :sales_commission_reports, :to => :manage
    has_permission_on :sales_commission_backlog_reports, :to => :manage
    has_permission_on :sales_reports, :to => :read
    has_permission_on :bookings_reports, :to => :read
    has_permission_on :backlog_reports, :to => :read
    has_permission_on :sales_opportunities, :to => :manage
    has_permission_on :sales_opportunity_comments, :to => :manage
    has_permission_on :sales_opportunity_reports, :to => :manage
    has_permission_on :sales_events, :to => :read
    has_permission_on :production_vendors, :to => :read
    has_permission_on :m2mhub_context_assistants, :to => :manage
    has_permission_on :production_purchase_order_items, :to => :read
    has_permission_on :production_purchase_orders, :to => :read
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
    has_permission_on :production_inspection_items, :to => :read
    has_permission_on :production_vendors, :to => :read
    has_permission_on :production_vendors_purchase_order_items, :to => :read
    has_permission_on :production_vendor_approvals, :to => :read
    has_permission_on :production_purchase_order_items, :to => :read
    has_permission_on :production_purchase_orders, :to => :read
  end
  
  role :manager do
    includes :shipping, :sales, :production
    has_permission_on :production_labor_reports, :to => :read
    has_permission_on :production_vendor_approvals, :to => :manage
  end

  role :admin do
    includes :manager
    has_permission_on :users_password, :to => [:manage, :update_without_current_password]
    has_permission_on :users, :to => [:manage, :set_role, :switch, :verify, :delete, :message]
    has_permission_on :m2mhub_user_activities, :to => :manage
    has_permission_on :production_inventory_reports, :to => :manage
    has_permission_on :sales_opportunities, :to => :delete_permanently
  end
end
 
privileges do
  privilege :manage, :includes => [:make, :read, :update, :destroy, :move, :fix_positions]
  privilege :read, :includes => [:index, :show]
  privilege :make, :includes => [:new, :create, :thanks]
  privilege :update, :includes => :edit
  privilege :set_role
end