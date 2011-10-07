# Provide trace output method that can be turned on/off via command-line.
class Object
  @@tracing = false
  class << self
    def tracing=(val)
      @@tracing = val
    end
    def tracing?
      @@tracing
    end
    # Passed blocks are only executed if tracing is on.
    def trace(msg=nil, &block)
      if self.tracing?
        puts msg if msg
        if block_given?
          puts yield
        end
      end
    end
  end
  def trace(msg=nil, &block)
    self.class.trace(msg, &block)
  end
end

Object.tracing = ARGV.include?('--trace')