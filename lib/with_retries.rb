module WithRetries  
  MAX_RETRIES=3
  def with_retries(&block)
    attempts = 0
    while ((attempts += 1) <= MAX_RETRIES)
      begin
        return yield
      rescue ActiveResource::ServerError => exception
        if attempts == MAX_RETRIES
          log_error "Server Error on attempt #{attempts}.  Giving up..."
          raise $!
        else
          log_error "Server Error on attempt #{attempts}.  Retrying..."
          log_error "#{exception.class.name} #{exception.message}" + exception.backtrace.join("\n")
        end
      rescue EOFError
        if attempts == MAX_RETRIES
          log_error "Timeout on attempt #{attempts}.  Giving up..."
          raise $!
        else
          log_error "Timeout on attempt #{attempts}.  Retrying..."
        end
      rescue
        raise $!
      end
    end
  end
end