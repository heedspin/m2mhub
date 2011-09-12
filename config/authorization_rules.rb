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
  end

  role :sales do
    includes :shipping
    has_permission_on :quotes, :to => :read
    has_permission_on :sales_orders, :to => :read
    has_permission_on :items, :to => :read
  end

  role :admin do
    includes :shipping, :sales
    has_permission_on :users_password, :to => [:manage, :update_without_current_password]
    has_permission_on :users, :to => [:manage, :set_role, :switch, :verify, :delete, :message]
    has_permission_on :content_modules, :to => :manage
  end
end
 
privileges do
  privilege :manage, :includes => [:make, :read, :update, :destroy, :move, :fix_positions]
  privilege :read, :includes => [:index, :show]
  privilege :make, :includes => [:new, :create, :thanks]
  privilege :update, :includes => :edit
  privilege :set_role
end