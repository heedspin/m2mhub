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
  map.resources :user_activities, :only => [:index]
<<<<<<< HEAD
  
  # Specify thing regular expression because the routes use '.' as separator.
  map.switch 'switch/:thing', :controller => 'switch', :action => 'switch', :thing => /.+/
=======
  map.resources :items, :only => [:index]
>>>>>>> 0a5454ad94bf17641dfe02c4b8344baa9163b472
end
