# == Schema Information
#
# Table name: m2mhub_external_events
#
#  id                    :integer          not null, primary key
#  status_id             :integer
#  source                :string(255)
#  json_data             :text
#  request_header        :text
#  delayed_job_id        :integer
#  delayed_job_status_id :integer
#  delayed_job_log       :text
#  delayed_job_method    :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  guid                  :string(255)
#

require 'plutolib/stateful_delayed_report'

class M2mhub::ExternalEvent < M2mhub::Base
  include Plutolib::StatefulDelayedReport
  self.table_name = 'm2mhub_external_events'
  belongs_to_active_hash :status, :class_name => 'M2mhub::ExternalEventStatus'
  scope :error, -> { where(:status_id => M2mhub::ExternalEventStatus.error.id) }
  validates_uniqueness_of :guid
  attr_accessor :dry_run
  
  before_validation :create_guid, :on => :create
  def create_guid
    key = if self.email.present?
      self.email
    elsif self.name.present?
      self.name
    else
      Digest::SHA1.hexdigest(self.data_hash.map(&:to_s).sort.join)
    end
    self.guid = "#{self.source}.#{key}"
  end
  
  def source_type
    if self.source.present?
      self.source.split(':').first
    else
      nil
    end
  end
  # Correct, but not currently used:
  # def source_id
  #   self.source.split('/').last
  # end
  
  def to_s
    [self.source, self.name, self.email].join(' / ')
  end
  
  # rails r "M2mhub::ExternalEvent.error.each(&:queue_to_run!)"
  def queue_to_run!
    self.status = M2mhub::ExternalEventStatus.queued
    self.save! if self.changed?
    self.run_in_background!
  end
  
  def run_report
    if handler_class = M2mhub::ExternalEventHandler.handler_class(self)
      handler = handler_class.new(self).run_main
      if self.status.try(:queued?)
        # Assume success.
        self.status = M2mhub::ExternalEventStatus.success
      end
      self.save if !self.dry_run && self.changed?
    end
    self.status == M2mhub::ExternalEventStatus.success
  end
  
  # def json_data=(thing)
  #   if thing.is_a?(Hash)
  #     @data_hash = thing
  #   end
  #   super(thing)
  # end
  # 
  attr_accessor :data_hash
  def data_hash
    @data_hash ||= self.json_data.present? ? ActiveSupport::JSON.decode(self.json_data) : {}
  end
  
  before_save :encode_data
  def encode_data
    self.json_data = self.data_hash.to_json
  end
  
  def as_json(args=nil)
    self.data_hash.as_json(args)
  end  

  def human_attribute_name(field)
    I18n.t "activerecord.attributes.external_events_#{self.source_type}.#{field}", :default => field.humanize
  end
  
  def human_source_name
    I18n.t "activerecord.models.external_events_#{self.source_type}", :default => self.source_type.humanize
  end
  
  def name
    (value(:first_name, '') + ' ' + value(:last_name, '')).strip
  end
  def website
    if (v = value(:website)).present?
      v
    elsif self.email.present?
      'www.' + self.email.split('@').last
    else
      nil
    end
  end
  def date
    if (v = value(:date))
      DateParser.parse(v)
    else
      nil
    end
  end
  def company
    if (v = value(:company)).present?
      v.titleize
    else
      nil
    end
  end
  def email
    @email ||= value(:email).try(:downcase)
  end
  def address
    @address ||= [value(:address1), value(:address2)].compact.join(', ').strip
  end

  # defaults:
  #   one: won 1 uno
  #   two: 2 dos
  # designeast:
  #   one: uberone
  #   two: superdos
  class Config
    include Singleton
    def initialize
      @alias_map = AppConfig.external_event_map || {}
    end
    def alias_keys_for(topkey, key)
      if submap = @alias_map[topkey] || @alias_map['defaults']
        submap[key]
      else
        nil
      end
    end
  end
  def value(key, default_value=nil)
    key = key.to_s
    result = nil
    search_keys = M2mhub::ExternalEvent::Config.instance.alias_keys_for(self.source_type, key) || [key]
    search_keys.each do |sk|
      if self.data_hash.member?(sk)
        return self.data_hash[sk]
      end
    end
    default_value
  end
  # def respond_to?(mid)
  #   super(mid) # || M2mhub::ExternalEvent::Config.instance.alias_keys_for(self.source_type, mid).present? || self.data_hash.member?(mid)
  # end
  def method_missing(mid, *args)
    if has_attribute?(mid)
      super
    else
      value(mid)
    end
  end
end
