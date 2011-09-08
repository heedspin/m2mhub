module ActiveHashMethods
  def self.included(base)
    static_methods = []
    instance_methods = []
    base.data.each do |config|
      if (cname = config[:name]) and (cid = config[:id])
        cmethod = config[:method] || cname.gsub(/[ -\/]/, '_').downcase
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
    ruby = <<-RUBY
    class << self
      #{static_methods.join("\n")}
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