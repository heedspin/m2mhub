# == Schema Information
#
# Table name: contexts
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  subject    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Context::Context < M2mhub::Base
  set_table_name 'contexts'
  has_many :group_contexts, :class_name => 'Context::GroupContext'
  has_many :groups, :class_name => 'Context::Group', :through => :group_contexts
  has_many :group_users, :class_name => 'Context::GroupUser', :through => :groups
  has_many :comments, :class_name => 'Context::Comment'
  
  def self.subject(text)
    where(:subject => text)
  end
  def self.accessible_to(user)
    user = user.id if user.is_a?(User)
    joins(:group_users).where({ :context_group_users => { :user_id => user }})
  end
  def accessible_to?(user)
    (self.group_users.where({ :context_group_users => { :user_id => user }}).count() == 1)
  end
  
  def to_context
    opportunities = Sales::Opportunity.with_parsed_xnumber(self.subject).limit(10)
    { :comments => self.comments.not_deleted.order(&:created_at).reverse.map(&:to_context),
      :opportunities => opportunities.map(&:to_context) }
  end
end
