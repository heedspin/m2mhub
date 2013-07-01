# == Schema Information
#
# Table name: context_threads
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Context::Context < M2mhub::Base
  set_table_name 'contexts'
end
