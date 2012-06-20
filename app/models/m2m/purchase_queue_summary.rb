# == Schema Information
#
# Table name: pqsumm
#
#  fcabc            :string(1)       default(""), not null
#  fcavendno        :string(6)       default(""), not null
#  fcavname         :string(35)      default(""), not null
#  fcavuom          :string(3)       default(""), not null
#  fccomment        :string(20)      default(""), not null
#  fcgroup          :string(6)       default(""), not null
#  fcpartdesc       :string(35)      default(""), not null
#  fcpartno         :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  fcplanner        :string(3)       default(""), not null
#  fcprcl           :string(2)       default(""), not null
#  fcpvendno        :string(6)       default(""), not null
#  fcpvname         :string(35)      default(""), not null
#  fcpvuom          :string(3)       default(""), not null
#  fcucdoc          :string(20)      default(""), not null
#  fcucsrc          :string(1)       default(""), not null
#  fcuom            :string(3)       default(""), not null
#  fdactdate        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdduedate        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdgentime        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flactreqd        :boolean         default(FALSE), not null
#  flactsel         :boolean         default(FALSE), not null
#  flstartpo        :boolean         default(FALSE), not null
#  flvendsel        :boolean         default(FALSE), not null
#  fnavconv         :decimal(17, 10) default(0.0), not null
#  fnininsp         :decimal(17, 5)  default(0.0), not null
#  fnleadtime       :integer(4)      default(0), not null
#  fnonhand         :decimal(17, 5)  default(0.0), not null
#  fnonord          :decimal(17, 5)  default(0.0), not null
#  fnordqty         :decimal(17, 5)  default(0.0), not null
#  fnqtyavail       :decimal(17, 5)  default(0.0), not null
#  fnreord          :decimal(17, 5)  default(0.0), not null
#  fnsafety         :decimal(17, 5)  default(0.0), not null
#  fnunitcost       :decimal(17, 5)  default(0.0), not null
#  fnnetavail       :decimal(17, 5)  default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#  fnonnetqty       :decimal(15, 5)  default(0.0), not null
#

class M2m::PurchaseQueueSummary < M2m::Base
  set_table_name 'pqsumm'
  belongs_to_item :fcpartno, :fcpartrev
  alias_attribute :comment, :fccomment
  alias_attribute :on_hand, :fnonhand
  alias_attribute :on_order, :fnonord
  alias_attribute :order_quantity, :fnordqty
  alias_attribute :quantity_available, :fnqtyavail
  alias_attribute :net_quantity_available, :fnnetavail
  alias_date_attribute :due_date, :fdduedate
  alias_date_attribute :actual_date, :fdactdate
  alias_attribute :vendor_name1, :fcavname
  alias_attribute :vendor_name2, :fcpvname
  
  def description
    if self.first_problem
      self.first_problem.document_number
    else
      "Issue #{self.id}"
    end
  end
  
  def details
    @details ||= M2m::PurchaseQueueDetail.for_summary(self).all.sort_by(&:sort_tuple)
  end
  
  def first_problem
    @first_problem ||= self.details.detect { |d| d.net_quantity_available < 0 }
  end
  
  def note
    @note ||= Production::PurchaseQueueNote.for_summary(self).first
  end
  def build_note
    @note = Production::PurchaseQueueNote.new(:part_number => self.part_number, :revision => self.revision, :due_date => self.first_problem.try(:due_date))
  end
  scope :for_note, lambda { |note|
    {
      :conditions => { :fcpartno => note.part_number, :fcpartrev => note.revision, :fdduedate => note.due_date }
    }
  }
  
  scope :by_due_date, :order => :fdduedate
end
