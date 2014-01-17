# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  notification_preference :integer
#  photo_file_name         :string(255)
#  photo_content_type      :string(255)
#  photo_file_size         :integer
#  user_state_id           :integer
#  user_role_id            :integer
#  email                   :string(255)
#  crypted_password        :string(255)
#  password_salt           :string(255)
#  persistence_token       :string(255)
#  single_access_token     :string(255)
#  perishable_token        :string(255)
#  login_count             :integer          default(0)
#  failed_login_count      :integer          default(0)
#  last_request_at         :datetime
#  current_login_at        :datetime
#  last_login_at           :datetime
#  current_login_ip        :string(255)
#  last_login_ip           :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  lighthouse_user_id      :string(255)
#

class User < M2mhub::Base
  # model_stamper
  acts_as_authentic do |c|
    c.validate_password_field = true
    c.maintain_sessions = false
  end
  belongs_to_active_hash :user_role
  belongs_to_active_hash :user_state
  attr_protected :password, :password_confirmation, :user_role, :user_state
  validates_presence_of :first_name, :last_name, :email, :user_state, :user_role
  has_many :user_messages, :dependent => :delete_all
  has_many :messages, :through => :user_messages
  belongs_to :notification_preference
  has_many :context_group_users, :class_name => 'Context::GroupUser'
  has_many :context_groups, :class_name => 'Context::Group', :through => :context_group_users, :source => :group

  attr_accessor :current_password
  scope :active, :conditions => { :user_state_id => UserState.active.id }
  scope :by_name, :order => [:first_name, :last_name]
  scope :with_lighthouse_account, :conditions => 'users.lighthouse_user_id is not null'
  
  # This method is necessary method for declarative_authorization to determine roles
  # Roles returns e.g. [:admin]
  def role_symbols
    [(self.user_role || UserRole.default).authorization_key]
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def name_and_email
    "#{full_name} #{email}".strip
  end

  def first_name_or_last
    first_name.present? ? first_name : last_name
  end

  def email_address_with_name
    if full_name.present?
      "\"#{full_name}\" #{email}"
    else
      email
    end
  end

  def to_trace
    "#{user_role.name} #{id} '#{full_name}'"
  end

  def destroy
    self.update_attributes(:user_state_id => UserState.deleted.id)
  end

  def deliver_verification_instructions!
    reset_perishable_token!
    UserVerification.verification_instructions(self).deliver
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetNotifier.password_reset_instructions(self).deliver
  end

  def verify!
    self.update_attributes(:user_state_id => UserState.active.id)
  end

  def self.robo_mailer
    find_by_email(AppConfig.email_address)
  end

  def self.new_from_email(email)
    user = new(:email => email)
    user.save(:validate => false)
    user
  end
  
  def as_json(args=nil)
    super((args || {}).merge({:only => [:id, :first_name, :last_name]}))
  end
  
  protected

    before_validation :set_default_status_and_role, :on => :create
    def set_default_status_and_role
      self.user_role_id ||= UserRole.default.id
      self.user_state_id ||= UserState.unconfirmed.id
    end
    
    before_save :find_lighthouse_account
    def find_lighthouse_account
      if AppConfig.lighthouse_account and self.lighthouse_user_id.blank?
        if lighthouse_user = Lighthouse::User.find_by_name(self.full_name)
          self.lighthouse_user_id = lighthouse_user.id
        end
      end
    end
end
