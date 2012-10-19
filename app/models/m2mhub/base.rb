require 'm2mhub/belongs_to_lighthouse'
class M2mhub::Base < ActiveRecord::Base
  include ::BelongsToLighthouse
  self.abstract_class = true
  extend ActiveHash::Associations::ActiveRecordExtensions
end