module StaticModel
  module ClassMethods
    def data=(configs)
      configs.each do |config|
        add_static_model(config)
      end
    end
    def add_static_model(config)
      static_name_method = config.delete(:method) || config[:name].gsub(/[ -\/]/, '_').downcase
      object_id = config.delete(:id)
      if object = cached_find(object_id)
        config.each do |attribute, value|
          object.send("#{attribute}=", value)
        end
        object.save if object.changed?
      else
        object = new(config)
        object.id = object_id
        object.save!
      end
      cache[static_name_method] = object
    end
    def cached_find(object_id)
      if @cached_find.nil?
        @cached_find = :done
        if count < 100
          @cached_by_id = {}
          all.each { |o| @cached_by_id[o.id] = o }
        end
      end
      (@cached_by_id && @cached_by_id[object_id]) || find_by_id(object_id)
    end
    def cache
      @cache ||= {}
    end
    def method_missing(mid, *args)
      if object = self.cache[mid.to_s]
        return object
      else
        super
      end
    end
  end
  def self.included(base)
    base.extend ClassMethods
  end
  def method_missing(mid, *args)
    if mid.to_s =~ /(.+)\?$/
      if object = self.class.cache[$1]
        return object.id == self.id
      end
    end
    super
  end  
end
  