class Amatcher
  class SortedArray < Array
    def self.[] *array
      SortedArray.new(array)
    end
    attr_accessor :maxlength
    def initialize(array=nil, maxlength=nil)
      @maxlength = maxlength
      super( array.sort ) if array
    end

    def << value
      insert index_of_last_LE(value), value
      # Keep max length.
      self.pop if self.maxlength and (self.length > maxlength)
      value
    end

    alias push <<
    alias shift <<

    def index_of_last_LE value
      # puts "Insertgin #{value} into #{inspect}"
      l,r = 0, length-1
      while l <= r
        m = (r+l) / 2
        # puts "#{l}(#{self[l]})--#{m}(#{self[m]})--#{r}(#{self[r]})"
        if value < self[m]
          r = m - 1
        else
          l = m + 1
        end
      end
      # puts "Answer: #{l}:(#{self[l]})"
      l
    end
  end
  
  class ReverseWeightedObject
    attr_accessor :object, :weight
    def initialize(object, weight)
      @object = object
      @weight = weight
    end
    def <=>(rhs)
      rhs.weight <=> self.weight
    end
    def <=(rhs)
      rhs.weight <= self.weight
    end
    def <(rhs)
      rhs.weight < self.weight
    end
  end
  
  def self.find_similar(args)
    match_string = args[:match] || (raise ':match required')
    objects = args[:objects] || (raise ':objects required')
    method = args[:method] || (raise ':method required')
    limit = args[:limit] || 10
    threshold = args[:threshold] || 0.0
    @results = Amatcher::SortedArray.new(nil, limit)
    objects.find_each do |object|
      if value = object.send(method)
        @results << Amatcher::ReverseWeightedObject.new(object, value.jarowinkler_similar(match_string))
      end
    end
    @results.select { |r| r.weight >= threshold }
  end
end