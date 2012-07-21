module Plutolib::SerializedAttributes
  def self.included(base)
    class << base
      def serialized_attribute(key, args=nil)
        args ||= {}
        storage_column = args[:data] || 'data'
        deserialize = args[:deserialize] || args[:des]
        unless self.method_defined?(storage_column)
          self.class_eval <<-RUBY
          def #{storage_column}
            if @#{storage_column}.nil?
              if x = super
                @#{storage_column} = x.is_a?(String) ? ActiveSupport::JSON.decode(x) : x
              else
                @#{storage_column} = Hash.new(0)
              end
            end
            @#{storage_column}
          end        
          protected
            before_save :serialize_#{storage_column}
            def serialize_#{storage_column}
              self.#{storage_column} = self.#{storage_column}.to_json
            end
          RUBY
        end
        if deserialize
          self.class_eval <<-RUBY
          def #{key}
            self.#{storage_column}['#{key}'].try(:send, '#{deserialize.to_s}')
          end
          RUBY
        else
          self.class_eval <<-RUBY
          def #{key}
            self.#{storage_column}['#{key}']
          end
          RUBY
        end
        self.class_eval <<-RUBY
        def #{key}=(val)
          self.#{storage_column}['#{key}'] = val
        end
        RUBY
      end
    end
  end
end