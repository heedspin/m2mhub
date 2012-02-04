class M2m::Base < ApplicationModel
  self.abstract_class = true
  set_primary_key 'identity_column'

  # m2m_key = "#{Rails.env}_m2m"
  # msg = if config = M2m::Base.configurations[m2m_key]
  #   begin
  #     self.establish_connection m2m_key
  #     "Connected #{m2m_key} to #{config.inspect}"
  #   rescue
  #     "Failed to connect #{m2m_key} to #{config.inspect}"
  #   end
  # else
  #   "No #{m2m_key} connection"
  # end
  # puts msg
  # Rails.logger.info msg
  # M2m::Base.logger = M2m::Base.logger
end
