class Lighthouse::Project
  def name
    attributes['name']
  end
  
  def milestones
    @milestons ||= Lighthouse::Milestone.find(:all, :params => {:project_id => self.id})
  end
end