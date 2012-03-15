module ActiveHashMethods
  def self.included(base)
    static_methods = []
    instance_methods = []
    base.data.each do |config|
      if (cname = config[:name]) and (cid = config[:id])
        cmethod = config[:method] || cname.gsub(/[ -\/]/, '_').downcase
        firstchar = cmethod[0..0]
        unless (firstchar >= '0') and (firstchar <= '9')
          static_methods.push << <<-RUBY
          def #{cmethod}
            @#{cmethod} ||= find(#{cid})
          end
          RUBY
          instance_methods.push <<-RUBY
          def #{cmethod}?
            self.id == #{cid}
          end
          RUBY
        end
      end
    end
    ruby = <<-RUBY
    class << self
      #{static_methods.join("\n")}
      def columns
        pk = ActiveRecord::ConnectionAdapters::Column.new(self.primary_key, nil, 'int(11)', false)
        pk.primary = true
        [pk,
         ActiveRecord::ConnectionAdapters::Column.new('name', nil, :string, true)]
      end
    end
    #{instance_methods.join("\n")}
    def to_s
      name
    end
    RUBY
    # puts "evaluating:\n #{ruby}"
    base.class_eval ruby
  end
end