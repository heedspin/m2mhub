Rails.application.routes.draw do
  resource :user_session
  root :to => 'home#index'
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  resource :user_session
  resources :users do
    member do
      delete 'delete'
    end
    resource :activation do
      member do
        get :delete
      end
    end
    resource :password, :only => [ :edit, :update ]
  end
  resources :password_resets
  resources :sales_orders, :only => [:index, :show], :controller => 'sales/sales_orders'
  resources :sales_order_items, :only => [:index, :show], :controller => 'sales/sales_order_items'
  resources :sales_order_releases, :only => [:index], :controller => 'sales/sales_order_releases'
  resources :m2m_quotes, :controller => 'sales/m2m_quotes'
  resources :sales_quotes, :controller => 'sales/quotes' do
    resources :items, :controller => 'sales/quote_items'
  end
  resources :m2mhub_user_activities, :as => 'history', :only => [:index], :controller => 'm2mhub/user_activities'
  resources :items do
    resources :sales_order_releases, :only => [:index], :controller => 'items/sales_order_releases'
    resources :purchase_order_items, :only => [:index], :controller => 'items/purchase_order_items'
    resources :m2m_quote_items, :only => [:index], :controller => 'items/m2m_quote_items'
    resource :history, :controller => 'items/history'
    resources :shippers, :only => [:index], :controller => 'items/shippers'
    resources :jobs, :only => [:index], :controller => 'items/jobs'
    resources :boms, :only => [:index], :controller => 'items/boms'
    resources :bom_parents, :only => [:index], :controller => 'items/bom_parents'
    resources :bom_children, :only => [:index], :controller => 'items/bom_children'
  end
  resources :m2m_customers do
    resources :sales_orders, :only => [:index], :controller => 'm2m_customers/sales_orders'
    resources :quotes, :only => [:index], :controller => 'm2m_customers/quotes'
    resources :contacts, :controller => 'm2m_customers/contacts'
    resources :invoiced_sales_reports, :controller => 'm2m_customers/invoiced_sales_reports'
    resources :sales_backlog_reports, :controller => 'm2m_customers/sales_backlog_reports'
  end
  resources :sales_customers, :controller => 'sales/customers' do
    resources :opportunities, :controller => 'sales/customers/opportunities'
    resources :quotes, :controller => 'sales/customers/quotes'
  end
  resources :sales_territories, :controller => 'sales/territories'
  resources :parent_companies, :controller => 'sales/parent_companies'
  resources :sales_backlog_reports, :only => [:index, :show], :controller => 'sales/backlog_reports'
  resources :customer_otd_reports, :only => [:new], :controller => 'quality/customer_otd_reports'
  resources :rma_reports, :only => [:new], :controller => 'quality/rma_reports'
  resources :credit_memo_reports, :only => [:new], :controller => 'quality/credit_memo_reports'
  resources :inspection_tasks, :controller => 'quality/inspection_tasks'
  resources :invoiced_sales_reports, :controller => 'sales/invoiced_sales_reports'
  resources :pro_forma_sales_reports, :controller => 'sales/pro_forma_sales_reports'
  resources :commission_rates, :controller => 'sales/commission_rates'
  resources :commission_reports, :controller => 'sales/commission_reports'
  resources :commission_backlog_reports, :controller => 'sales/commission_backlog_reports'
  match 'quality' => 'quality/quality_dashboard#index'
  resources :sales_reports, :only => [:index, :show], :controller => 'sales/sales_reports'
  resources :bookings_reports, :only => :show, :controller => 'sales/bookings_reports'
  resources :opportunities, :controller => 'sales/opportunities'
  resources :opportunity_comments, :controller => 'sales/opportunity_comments'
  resources :opportunity_reports, :controller => 'sales/opportunity_reports'
  match 'sales_scoreboard' => 'sales/opportunity_reports#new'
  
  match 'shipping' => 'shipping/shipping_dashboard#index'
  resources :shippers, :only => [:index, :show], :controller => 'shipping/shippers'
  resources :receivers, :only => [:index, :show], :controller => 'shipping/receivers'
  resources :shipping_backlog_reports, :only => [:index, :show], :controller => 'shipping/backlog_reports'
  
  resources :rmas, :only => [:show], :controller => 'quality/rmas'

  match 'production' => 'production/production_dashboard#index'
  resources :work_center_load_reports, :only => [:new], :controller => 'production/work_center_load_reports'
  resources :inventory_reports, :controller => 'production/inventory_reports' do
    resources :customer_reports, :only => [:index, :show], :controller => 'production/inventory_reports/customer_reports'
    resources :obsolete_reports, :only => [:index], :controller => 'production/inventory_reports/obsolete_reports'
  end
  resources :labor_reports, :only => [:index, :show], :controller => 'production/labor_reports'
  resources :purchase_queue_summaries, :only => [:index, :show], :controller => 'production/purchase_queue_summaries'
  resources :purchase_queue_notes, :controller => 'production/purchase_queue_notes'
  resources :inspection_item, :only => [:index, :show], :controller => 'production/inspection_items'
  resources :vendors, :only => [:index, :show], :controller => 'production/vendors' do
    resources :purchase_order_items, :only => [:index], :controller => 'production/vendors/purchase_order_items'
  end
  resources :vendor_approvals, :controller => 'production/vendor_approvals'
  resources :purchase_order_items, :only => [:index], :controller => 'production/purchase_order_items'
  resources :purchase_orders, :only => [:show], :controller => 'production/purchase_orders'
  
  resources :m2mhub_triggers, :controller => 'm2mhub/triggers'
  resources :m2mhub_events, :controller => 'm2mhub/events'
  resources :external_event_resources, :controller => 'm2mhub/external_event_resources', :only => [:create]

  # Specify thing regular expression because the routes use '.' as separator.
  match 'switch/:thing' => 'switch#switch', :thing => /.+/, :as => 'switch'
end
