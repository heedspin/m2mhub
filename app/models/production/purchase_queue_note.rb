# == Schema Information
#
# Table name: purchase_queue_notes
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  part_number :string(255)
#  revision    :string(255)
#  comments    :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Production::PurchaseQueueNote < M2mhub::Base
  belongs_to :item, :class_name => 'M2m::Item'
  scope :by_date_desc, :order => 'purchase_queue_notes.created_at desc'
  scope :for_summary, lambda { |summary|
    {
      :conditions => { :part_number => summary.part_number, :revision => summary.revision }
    }
  }
  def summary
    @summary ||= M2m::PurchaseQueueSummary.for_note(self).first
  end
end  
