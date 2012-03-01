module ActiveHashSetter
  def self.included(base)
    class << base
      def active_hash_setter(klass)
        attr_key = klass.name.demodulize.underscore
        attr_id = ":#{attr_key}_id"
        self.class_eval <<-TEXT
          belongs_to_active_hash :#{attr_key}, :class_name => '#{klass.name}'
          def #{attr_key}=(thing)
            if thing.is_a?(#{klass.name})
              write_attribute(#{attr_id}, thing.id)
            elsif thing.is_a?(String)
              if new_thing = #{klass.name}.find_by_name(thing)
                write_attribute(#{attr_id}, new_thing.id)
              else
                exc = thing + ' is not a valid #{klass.name}'
                raise exc
              end
            elsif thing.nil?
              write_attribute(#{attr_id}, nil)
            else
              raise ActiveRecord::AssociationTypeMismatch.new('Expected #{klass.name}, got ' + thing.class.name + ' ' + thing.to_s)
            end
          end
        TEXT
      end
    end
  end
end