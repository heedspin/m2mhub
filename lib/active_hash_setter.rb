require 'active_hash'

module ActiveHashSetter
  def self.included(base)
    base.extend ActiveHash::Associations::ActiveRecordExtensions
    class << base
      def active_hash_setter(klass, attr_key=nil, attr_id=nil)
        attr_key ||= klass.name.demodulize.underscore
        attr_id ||= "#{attr_key}_id"
        foreign_key = ":#{attr_id}"
        self.class_eval <<-TEXT
          belongs_to_active_hash :#{attr_key}, :class_name => '#{klass.name}', :foreign_key => #{foreign_key}
          def #{attr_key}=(thing)
            if thing.is_a?(#{klass.name})
              write_attribute(#{foreign_key}, thing.id)
            elsif thing.is_a?(String) and thing.present?
              if new_thing = thing.to_i.to_s == thing ? #{klass.name}.find_by_id(thing) : #{klass.name}.find_by_name(thing)
                write_attribute(#{foreign_key}, new_thing.id)
              else
                exc = thing + ' is not a valid #{klass.name}'
                raise exc
              end
            elsif !thing.present?
              write_attribute(#{foreign_key}, nil)
            else
              raise ActiveRecord::AssociationTypeMismatch.new('Expected #{klass.name}, got ' + thing.class.name + ' ' + thing.to_s)
            end
          end
          scope :#{attr_key}, lambda { |val|
            {
              :conditions => { #{foreign_key} => val.id }
            }
          }          
        TEXT
      end
    end
  end
end