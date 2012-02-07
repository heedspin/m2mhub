class M2m::Base < ApplicationModel
  self.abstract_class = true
  set_primary_key 'identity_column'
  
  def self.belongs_to_item(part_number_field, revision_field, item_method_base=:item)
    item_method_base = item_method_base.to_s
    part_number_method = item_method_base == 'item' ? 'part_number' : "#{item_method_base}_part_number"
    revision_method = item_method_base == 'item' ? 'revision' : "#{item_method_base}_revision"
    item_method = item_method_base == 'item' ? 'item' : "#{item_method_base}_item"
    self.class_eval <<-RUBY
    def #{part_number_method}
      @#{part_number_method} ||= self.#{part_number_field}.strip
    end
    def #{revision_method}
      @#{revision_method} ||= self.#{revision_field}.strip
    end
    attr_accessor :#{item_method}
    def #{item_method}
      @#{item_method} ||= M2m::Item.part_number(self.#{part_number_method}).revision(self.#{revision_method}).first
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
