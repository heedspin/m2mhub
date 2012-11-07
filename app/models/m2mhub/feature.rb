class M2mhub::Feature
  class << self
    attr_accessor :current_user
    def enabled?(feature)
      current_user.present? && self.users_for_feature(feature).member?(current_user.email)
    end
    
    def users_for_feature(feature)
      @users_for_feature ||= Hash.new
      if (users = @users_for_feature[feature]).nil?
        users = Set.new
        if email_string = AppConfig.get("feature_#{feature}")
          users = email_string.split(',').map(&:strip).compact
        end
        @users_for_feature[feature] = users
      end
      users
    end
  end
end