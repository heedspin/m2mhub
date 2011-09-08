class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.integer :notification_preference
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size        
      t.references :user_status
      t.references :user_role
      t.string    :email                              # optional, you can use login instead, or both
      t.string    :crypted_password                   # optional, see below
      t.string    :password_salt                      # optional, but highly recommended
      t.string    :persistence_token                  # required
      t.string    :single_access_token                # optional, see Authlogic::Session::Params
      t.string    :perishable_token                   # optional, see Authlogic::Session::Perishability
      t.integer   :login_count,         :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                      # optional, see Authlogic::Session::MagicColumns
      t.timestamps
    end
    add_index :users, :perishable_token
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
