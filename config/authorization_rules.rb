authorization do
  
  role :guest do
  end

  role :user do
    has_permission_on [:users, :passwords], :to => [:show,:update,:destroy] do
      if_attribute :id => is {user.id}
    end
    has_permission_on :log_events, :to => :create
    if !Rails.env.production?
      has_permission_on :users, :to => :switch
    end
    has_permission_on :user_messages, :to => :manage do
      if_attribute :user_id => is {user.id}
    end
  end

  role :admin do
    includes :user, :guest
    has_permission_on :users_password, :to => [:manage, :update_without_current_password]
    has_permission_on :users, :to => [:manage, :set_role, :switch, :verify, :delete, :message]
    has_permission_on :log_events, :to => :manage
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