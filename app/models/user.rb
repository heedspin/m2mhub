class User < ApplicationModel
  model_stamper
  acts_as_authentic do |c|
    c.validate_password_field = true
    c.maintain_sessions = false
  end
  belongs_to :user_role
  belongs_to :user_status
  attr_protected :password, :password_confirmation, :user_role, :user_status
  validates_presence_of :first_name, :last_name, :email, :user_status, :user_role

  has_many :user_messages, :dependent => :delete_all
  has_many :messages, :through => :user_messages

  belongs_to :notification_preference

  attr_accessor :current_password
  scope :active, :conditions => { :user_status_id => UserStatus.active.id }
  
  # This method is necessary method for declarative_authorization to determine roles
  # Roles returns e.g. [:admin]
  def role_symbols
    [self.user_role.downcase.to_sym]
  end
  
  # For Declarative Auth.
  def role_symbols
    @role_symbols ||= (!user_role.nil?) ? [user_role.name.downcase.to_sym] : []
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
    self.update_attributes(:user_status_id => UserStatus.deleted.id)
  end

  def deliver_verification_instructions!
    reset_perishable_token!
    UserVerification.deliver_verification_instructions(self)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetNotifier.deliver_password_reset_instructions(self)
  end

  def verify!
    self.update_attributes(:user_status_id => UserStatus.active.id)
  end

  def self.robo_mailer
    find_by_email(AppConfig.email_address)
  end

  def self.new_from_email(email)
    user = new(:email => email)
    user.save(:validate => false)
    user
  end

  protected

    before_validation :set_default_status_and_role, :on => :create
    def set_default_status_and_role
      self.user_role_id ||= UserRole.user.id
      self.user_status_id ||= UserStatus.unconfirmed.id
    end
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer(4)      not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  notification_preference :integer(4)
#  photo_file_name         :string(255)
#  photo_content_type      :string(255)
#  photo_file_size         :integer(4)
#  user_status_id          :integer(4)
#  user_role_id            :integer(4)
#  email                   :string(255)
#  crypted_password        :string(255)
#  password_salt           :string(255)
#  persistence_token       :string(255)
#  single_access_token     :string(255)
#  perishable_token        :string(255)
#  login_count             :integer(4)      default(0)
#  failed_login_count      :integer(4)      default(0)
#  last_request_at         :datetime
#  current_login_at        :datetime
#  last_login_at           :datetime
#  current_login_ip        :string(255)
#  last_login_ip           :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#

