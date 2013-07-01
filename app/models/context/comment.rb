# == Schema Information
#
# Table name: context_comments
#
#  id         :integer          not null, primary key
#  context_id :integer
#  text       :text
#  creator_id :integer
#  created_at :datetime
#  updated_at :datetime
#  deleted    :boolean
#

require 'm2mhub_current_user'

class Context::Comment < M2mhub::Base
  set_table_name 'context_comments'
  belongs_to :context, :class_name => 'Context::Context'
  belongs_to :creator, :class_name => 'User'
  
  attr_accessor :subject
  attr_protected :creator_id
  
  def self.not_deleted
    where('context_comments.deleted is null or context_comments.deleted = false')
  end
  
  before_validation :set_creator, :on => :create
  def set_creator
    self.creator_id ||= M2mhubCurrentUser.user.try(:id)
  end
  
  before_validation :fill_in_context
  def fill_in_context
    if self.context_id.nil? and self.subject.present? and self.creator
      unless self.context = Context::Context.subject(self.subject).accessible_to(self.creator).order(:created_at).last
        self.context = Context::Context.create(:subject => self.subject)
        group = self.creator.context_groups.first
        unless group
          group = self.creator.context_groups.create
        end          
        group.contexts << self.context
      end
    end
  end

  validates_presence_of :context_id, :text, :creator_id
  validate :creator_has_access_to_context, :on => :create
  def creator_has_access_to_context
    if self.context and self.creator
      unless group_user = self.context.group_users.user(self.creator).first
        self.errors.add(:context, "User does not have access to this context")
      end
    end
  end
  
  def to_context
    {
      :id => self.id,
      :text => self.text,
      :creator_first_name => self.creator.try(:first_name),
      :creator_last_name => self.creator.try(:last_name),
      :creator_id => self.creator_id
    }
  end
  
end
