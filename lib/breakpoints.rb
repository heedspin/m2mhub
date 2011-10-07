class Breakpoints
  include Singleton
  def initialize
    @breakpoints = Hash.new
  end
  DEFAULT_KEY='default_key'
  def set(key=DEFAULT_KEY, value=true)
    @breakpoints[key.to_s] = value
  end
  def set?(key=DEFAULT_KEY)
    @breakpoints[key.to_s]
  end
  # Breakpoint until cleared
  def buc(key=DEFAULT_KEY)
    if @breakpoints.member?(key.to_s)
      @breakpoints[key.to_s]
    else
      @breakpoints[key.to_s] = true
    end
  end
  
  def clear(key=nil)
    if key
      @breakpoints[key] = false
    else
      @breakpoints.keys.each { |k| @breakpoints[k] = false }
    end
  end
  def set_once(key=DEFAULT_KEY)
    if @breakpoints.member?(key.to_s)
      @breakpoints[key.to_s]
    else
      # Return true just once.
      @breakpoints[key.to_s] = false
      true
    end
  end
  
  class << self
    def set(key=DEFAULT_KEY)
      instance.set(key)
    end
    def set?(key=DEFAULT_KEY)
      instance.set?(key)
    end
    def clear(key=nil)
      instance.clear(key)
    end
    def set_once(key=DEFAULT_KEY)
      instance.set_once(key)
    end
    def buc(key=DEFAULT_KEY)
      instance.buc(key)
    end
  end
end