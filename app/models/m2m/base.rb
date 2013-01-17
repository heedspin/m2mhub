require 'm2m/belongs_to_item'

class M2m::Base < ActiveRecord::Base
  self.abstract_class = true
  set_primary_key 'identity_column'
  include ::BelongsToItem
  extend ActiveHash::Associations::ActiveRecordExtensions

  def self.m2m_id_setter(column, num_digits, name=nil)
    name ||= column
    alias_code = if name != column
      "alias_attribute '#{name}', '#{column}'"
    end
    self.class_eval <<-RUBY
    #{alias_code}
    def self.#{name}_for(val)
        '%0#{num_digits}d' % val.to_i
    end
    def #{name}=(val)
      write_attribute('#{column}', self.class.send('#{name}_for', val))
    end
    RUBY
  end

  def self.alias_date_attribute(new_name, old_name)
    self.class_eval <<-RUBY
    alias_attribute '#{new_name}', '#{old_name}'
    def #{new_name}
      M2m::Constants.sanitize_date(self.send('#{old_name}'))
    end
    RUBY
  end

  # Useful after loading object and before rendering edit.
  def strip_strings
    self.class.columns.each do |column|
      if [:string, :text].include?(column.type)
        self.send("#{column.name}=", self.send(column.name).try(:strip))
      end
    end
  end

  # Turn off all time zone conversions.
  # http://info.michael-simons.eu/2008/11/01/turn-off-rors-automatic-timezone-conversion-for-columns/
  def self.time_zone_aware_attributes
    false
  end
  
  # String#titleize will remove hashes.
  def self.safe_titleize(txt)
    return nil if txt.nil?
    txt.strip.gsub(/(\w+)/) { |m| $1.capitalize }
  end

  m2m_key = "#{Rails.env}_m2m"
  msg = if config = M2m::Base.configurations[m2m_key]
    begin
      self.establish_connection m2m_key
      "Connected #{m2m_key} to #{config.inspect}"
    rescue
      "Failed to connect #{m2m_key} to #{config.inspect}"
    end
  else
    "No #{m2m_key} connection"
  end
  puts msg
  Rails.logger.info msg
  M2m::Base.logger = M2m::Base.logger
end
