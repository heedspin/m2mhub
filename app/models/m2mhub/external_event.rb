# == Schema Information
#
# Table name: m2mhub_external_events
#
#  id                    :integer(4)      not null, primary key
#  status_id             :integer(4)
#  source                :string(255)
#  json_data             :text
#  request_header        :text
#  delayed_job_id        :integer(4)
#  delayed_job_status_id :integer(4)
#  delayed_job_log       :text
#  delayed_job_method    :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'plutolib/stateful_delayed_report'

class M2mhub::ExternalEvent < M2mhub::Base
  include Plutolib::StatefulDelayedReport
  set_table_name 'm2mhub_external_events'
  
  after_create :run_in_background! # will call run_report.
  def run_report
    if handler_class = M2mhub::ExternalEventHandler.handler_class(self)
      handler_class.new(self).run
    end
  end
  
  # def json_data=(thing)
  #   if thing.is_a?(Hash)
  #     @data_hash = thing
  #   end
  #   super(thing)
  # end
  # 
  def data_hash
    @data_hash ||= self.json_data.present? ? ActiveSupport::JSON.decode(self.json_data) : {}
  end
  
  before_save :encode_data
  def encode_data
    self.json_data = self.data_hash.to_json
  end  
  
  def method_missing(mid, *args)
    mid = mid.to_s
    if self.data_hash.member?(mid)
      self.data_hash[mid]
    else
      super(mid, *args)
    end
  end
  
  def human_attribute_name(field)
    I18n.t "activerecord.attributes.external_events_#{self.source}.#{field}", :default => field.humanize
  end
  
  def human_source_name
    I18n.t "activerecord.models.external_events_#{self.source}", :default => self.source.humanize
  end
end
