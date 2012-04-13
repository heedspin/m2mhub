class SignalHandler
  include Singleton
  
  def initialize
    @shutdown = false
  end
  
  def register_int_to_shutdown
    Signal.trap("INT") do
      puts "INT: Shutting down..."
      @shutdown = true
    end
    Signal.trap("TERM") do
      puts "TERM: Shutting down..."
      @shutdown = true
    end
  end
  
  def shutdown?
    @shutdown
  end
  
  def shutdown=(value)
    @shutdown = value
  end
end