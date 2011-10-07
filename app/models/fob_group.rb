require 'active_hash_methods'
class FobGroup < ActiveHash::Base
  self.data = CompanyConfig.fob_groups
  include ActiveHashMethods
  
  def self.find_by_fob(fob)
    fob = fob.strip.downcase
    self.all.detect { |fg| fg.member?(fob) } || self.default
  end
  
  def member?(fob)
    fob = fob.strip.downcase
    # If this is the default group, members are the fobs that are not in any other group.  Mud?
    if self.default?
      (FobGroup.all.detect { |fg| !fg.default? && fg.member?(fob) }).nil?
    else
      ((self.members || []).detect { |m| m.downcase == fob }).present?
    end
  end
  
  def self.default
    self.all.detect { |fg| fg.default }
  end
end
