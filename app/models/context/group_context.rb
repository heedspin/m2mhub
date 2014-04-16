# == Schema Information
#
# Table name: context_group_contexts
#
#  id            :integer          not null, primary key
#  group_id      :integer
#  context_id    :integer
#  permission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Context::GroupContext < M2mhub::Base
  self.table_name = 'context_group_contexts'
  belongs_to :group, :class_name => 'Context::Group'
  belongs_to :context, :class_name => 'Context::Context'
end
