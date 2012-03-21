module BelongsToItem
  module ClassMethods
    def belongs_to_item(part_number_field='part_number', revision_field='revision', item_method_base=:item)
      item_method_base = item_method_base.to_s
      part_number_method = item_method_base == 'item' ? 'part_number' : "#{item_method_base}_part_number"
      revision_method = item_method_base == 'item' ? 'revision' : "#{item_method_base}_revision"
      item_method = item_method_base == 'item' ? 'item' : "#{item_method_base}_item"
      x = []
      unless part_number_method == part_number_field
        x.push <<-RUBY
        def #{part_number_method}
          @#{part_number_method} ||= self.#{part_number_field}.strip
        end
        RUBY
      end
      unless revision_method == revision_field
        x.push <<-RUBY
        def #{revision_method}
          @#{revision_method} ||= self.#{revision_field}.strip
        end
        RUBY
      end
      self.class_eval <<-RUBY
      #{x.join("\n")}
      attr_accessor :#{item_method}
      def #{item_method}
        unless @_loaded_item
          @#{item_method} = M2m::Item.part_number(self.#{part_number_method}).revision(self.#{revision_method}).first
          @_loaded_item = true
        end
        @#{item_method}
      end
      def #{item_method}=(val)
        @_loaded_item = true
        @#{item_method} = val
      end
      def is_for_item?(item)
        (self.part_number == item.part_number) && (self.revision == item.revision)
      end
      RUBY
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end