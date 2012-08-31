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
  resources :sales_orders, :only => [:index, :show]
  resources :sales_order_items, :only => [:index, :show]
  resources :sales_order_releases, :only => [:index]
  resources :quotes
  resources :user_activities, :as => 'history', :only => [:index]
  resources :items do
    resources :sales_order_releases, :only => [:index], :controller => 'items/sales_order_releases'
    resources :purchase_order_items, :only => [:index], :controller => 'items/purchase_order_items'
    resources :quote_items, :only => [:index], :controller => 'items/quote_items'
    resource :history, :controller => 'items/history'
    resources :shippers, :only => [:index], :controller => 'items/shippers'
    resources :jobs, :only => [:index], :controller => 'items/jobs'
    resources :boms, :only => [:index], :controller => 'items/boms'
    resources :bom_parents, :only => [:index], :controller => 'items/bom_parents'
    resources :bom_children, :only => [:index], :controller => 'items/bom_children'
  end
  resources :customers do
    resources :sales_orders, :only => [:index], :controller => 'customers/sales_orders'
    resources :quotes, :only => [:index], :controller => 'customers/quotes'
    resources :contacts, :controller => 'customers/contacts'
    resources :invoiced_sales_reports, :controller => 'customers/invoiced_sales_reports'
    resources :sales_backlog_reports, :controller => 'customers/sales_backlog_reports'
  end
  resources :sales_backlog_reports, :only => [:index, :show]  
  resources :customer_otd_reports, :only => [:new], :controller => 'quality/customer_otd_reports'
  resources :rma_reports, :only => [:new], :controller => 'quality/rma_reports'
  resources :credit_memo_reports, :only => [:new], :controller => 'quality/credit_memo_reports'
  resources :invoiced_sales_reports, :controller => 'sales/invoiced_sales_reports'
  resources :pro_forma_sales_reports, :controller => 'sales/pro_forma_sales_reports'
  resources :commission_rates, :controller => 'sales/commission_rates'
  resources :commission_reports, :controller => 'sales/commission_reports'
  match 'quality' => 'quality/quality_dashboard#index'
  resources :sales_reports, :only => [:index, :show], :controller => 'sales/sales_reports'
  resources :bookings_reports, :only => :show, :controller => 'sales/bookings_reports'
  resources :backlog_report, :only => [:index, :show], :controller => 'sales/backlog_reports'
  resources :opportunities, :controller => 'sales/opportunities'
  resources :opportunity_comments, :controller => 'sales/opportunity_comments'
  
  match 'shipping' => 'shipping/shipping_dashboard#index'
  resources :shippers, :only => [:index, :show], :controller => 'shipping/shippers'
  resources :receivers, :only => [:index, :show], :controller => 'shipping/receivers'
  
  resources :rmas, :only => [:show], :controller => 'quality/rmas' do
    resource :lighthouse_ticket, :only => :create, :controller => 'quality/lighthouse_tickets'
  end

  match 'production' => 'production/production_dashboard#index'
  resources :work_center_load_reports, :only => [:new], :controller => 'production/work_center_load_reports'
  resources :inventory_reports, :controller => 'production/inventory_reports' do
    resources :customer_reports, :only => [:index, :show], :controller => 'production/inventory_reports/customer_reports'
    resources :obsolete_reports, :only => [:index], :controller => 'production/inventory_reports/obsolete_reports'
  end
  resources :labor_reports, :only => [:index, :show], :controller => 'production/labor_reports'
  resources :purchase_queue_summaries, :only => [:index, :show], :controller => 'production/purchase_queue_summaries'
  resources :purchase_queue_notes, :controller => 'production/purchase_queue_notes'
  
  resources :m2mhub_triggers, :controller => 'm2mhub/triggers'
  resources :m2mhub_events, :controller => 'm2mhub/events'

  # Specify thing regular expression because the routes use '.' as separator.
  match 'switch/:thing' => 'switch#switch', :thing => /.+/, :as => 'switch'
end
