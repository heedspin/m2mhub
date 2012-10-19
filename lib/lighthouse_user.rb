class Lighthouse::User
  def self.find_by_name(name)
    self.users_cache[name]
  end
  
  def self.users_cache
    if @users_cache.nil?
      @users_cache = {}
      Lighthouse::Project.first.memberships.each do |membership|
        user = Lighthouse::User.find(membership.user_id)
        @users_cache[user.name] = user
      end
    end
    @users_cache
  end
  
  def self.options
    @options ||= users_cache.values.map { |u| [u.name, u.id] }.uniq.sort_by(&:first)
  end
end