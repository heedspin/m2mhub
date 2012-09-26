# http://blog.bigbinary.com/2009/01/21/override-automatic-timestamp-in-activerecord-rails.html
module ActiveRecord
  class Base

    def save_without_timestamping!
      class << self
        def record_timestamps; false; end
      end

      save!

      class << self
        remove_method :record_timestamps
      end
    end

  end
end