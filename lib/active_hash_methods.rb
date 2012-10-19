module ActiveHashMethods
  def self.included(base)
    static_methods = []
    instance_methods = []
    cmethod_values = {}
    base.data.each do |config|
      if (cname = config[:name]) and (cid = config[:id])
        cmethod = (config[:cmethod] || cname.gsub(/[ -\/]/, '_')).to_s.downcase.to_sym
        cmethod_values[cid] = cmethod
        next if [:all].include?(cmethod)
        firstchar = cmethod.to_s[0..0]
        next if (firstchar >= '0') and (firstchar <= '9')
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
    define_getter_method(:cmethod, nil)
    define_setter_method(:cmethod)
    def to_s
      name
    end
    RUBY
    # puts "evaluating:\n #{ruby}"
    base.class_eval ruby
    cmethod_values.each do |id, cmethod|
      base.find(id).cmethod = cmethod
    end
  end
end