require 'm2m/belongs_to_item'
require 'm2mhub/belongs_to_lighthouse'
require 'plutolib/logger_utils'
class M2mhub::Base < ActiveRecord::Base
  include Plutolib::LoggerUtils
  include ::BelongsToLighthouse
  self.abstract_class = true
  extend ActiveHash::Associations::ActiveRecordExtensions
  include ::BelongsToItem
end