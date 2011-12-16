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
  map.resources :quote_items, :only => [:index]
  map.resources :user_activities, :as => 'history', :only => [:index]
  map.resources :items, :only => [:index] do |item|
    item.resources :sales_order_releases, :only => [:index], :controller => 'items/sales_order_releases'
    item.resources :purchase_order_items, :only => [:index], :controller => 'items/purchase_order_items'
    item.resources :quote_items, :only => [:index], :controller => 'items/quote_items'
    item.resource :history, :controller => 'items/history'
    item.resources :shippers, :only => [:index], :controller => 'items/shippers'
    item.resources :jobs, :only => [:index], :controller => 'items/jobs'
  end
  map.item 'items/:id', :controller => 'items', :action => 'show', :id => /.+/
  map.resources :quotes, :only => [:index, :show]
  map.resources :customers, :only => [:index, :show] do |customer|
    customer.resources :sales_orders, :only => [:index], :controller => 'customers/sales_orders'
    customer.resources :quotes, :only => [:index], :controller => 'customers/quotes'
  end
  map.resources :shippers, :only => [:index, :show]
  map.resources :sales_backlog_reports, :only => [:index, :show]  
  map.resources :customer_otd_reports, :only => [:new]
  map.resources :rma_reports, :only => [:new]
  map.quality 'quality', :controller => 'quality', :action => 'index'

  # Specify thing regular expression because the routes use '.' as separator.
  map.switch 'switch/:thing', :controller => 'switch', :action => 'switch', :thing => /.+/
end
