ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.root :controller => "home"
  map.login  'login',  :controller => "user_sessions", :action => "new"
  map.logout 'logout', :controller => "user_sessions", :action => "destroy"
  map.resources :users, :member => {:delete => :get} do |user|
    # user.resource :activation, :controller => "users/activation", :member => {:delete => :get}
    user.resource :password #, :controller => "users/password"
  end
  map.resources :password_resets
  map.resources :sales_orders, :only => [:index, :show]
  map.resources :sales_order_items, :only => [:index, :show]
  map.resources :sales_order_releases, :only => [:index]
  map.resources :quotes
  map.resources :user_activities, :as => 'history', :only => [:index]
  map.resources :items, :requirements => { :id => /[^\/]+/ } do |item|
    item.resources :sales_order_releases, :only => [:index], :controller => 'items/sales_order_releases', :requirements => { :item_id => /[^\/]+/ }
    item.resources :purchase_order_items, :only => [:index], :controller => 'items/purchase_order_items', :requirements => { :item_id => /[^\/]+/ }
    item.resources :quote_items, :only => [:index], :controller => 'items/quote_items', :requirements => { :item_id => /[^\/]+/ }
    item.resource :history, :controller => 'items/history', :requirements => { :item_id => /[^\/]+/ }
    item.resources :shippers, :only => [:index], :controller => 'items/shippers', :requirements => { :item_id => /[^\/]+/ }
    item.resources :jobs, :only => [:index], :controller => 'items/jobs', :requirements => { :item_id => /[^\/]+/ }
  end
  map.resources :customers, :only => [:index, :show] do |customer|
    customer.resources :sales_orders, :only => [:index], :controller => 'customers/sales_orders'
    customer.resources :quotes, :only => [:index], :controller => 'customers/quotes'
  end
  map.resources :sales_backlog_reports, :only => [:index, :show]  
  map.resources :customer_otd_reports, :only => [:new], :controller => 'quality/customer_otd_reports'
  map.resources :rma_reports, :only => [:new], :controller => 'quality/rma_reports'
  map.resources :credit_memo_reports, :only => [:new], :controller => 'quality/credit_memo_reports'
  map.quality 'quality', :controller => 'quality/quality_dashboard', :action => 'index'
  
  map.shipping 'shipping', :controller => 'shipping/shipping_dashboard', :action => 'index'
  map.resources :shippers, :only => [:index, :show], :controller => 'shipping/shippers'
  map.resources :receivers, :only => [:index, :show], :controller => 'shipping/receivers'
  
  map.resources :rmas, :only => [:show], :controller => 'quality/rmas' do |rma|
    rma.resource :lighthouse_ticket, :only => :create, :controller => 'quality/lighthouse_tickets'
  end

  map.production 'production', :controller => 'production/production_dashboard', :action => 'index'
  map.resources :work_center_load_reports, :only => [:new], :controller => 'production/work_center_load_reports'

  # Specify thing regular expression because the routes use '.' as separator.
  map.switch 'switch/:thing', :controller => 'switch', :action => 'switch', :thing => /.+/
end
