# == Schema Information
#
# Table name: pqsumm
#
#  fcabc            :char(1)          default(" "), not null
#  fcavendno        :char(6)          default("      "), not null
#  fcavname         :varchar(35)      default(""), not null
#  fcavuom          :char(3)          default("   "), not null
#  fccomment        :char(20)         default("                    "), not null
#  fcgroup          :char(6)          default("      "), not null
#  fcpartdesc       :varchar(35)      default(""), not null
#  fcpartno         :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  fcplanner        :char(3)          default("   "), not null
#  fcprcl           :varchar(4)       default(""), not null
#  fcpvendno        :char(6)          default("      "), not null
#  fcpvname         :varchar(35)      default(""), not null
#  fcpvuom          :char(3)          default("   "), not null
#  fcucdoc          :char(20)         default("                    "), not null
#  fcucsrc          :char(1)          default(" "), not null
#  fcuom            :char(3)          default("   "), not null
#  fdactdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdduedate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdgentime        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flactreqd        :boolean          default(FALSE), not null
#  flactsel         :boolean          default(FALSE), not null
#  flstartpo        :boolean          default(FALSE), not null
#  flvendsel        :boolean          default(FALSE), not null
#  fnavconv         :decimal(17, 10)  default(0.0), not null
#  fnininsp         :decimal(17, 5)   default(0.0), not null
#  fnleadtime       :integer          default(0), not null
#  fnonhand         :decimal(17, 5)   default(0.0), not null
#  fnonord          :decimal(17, 5)   default(0.0), not null
#  fnordqty         :decimal(17, 5)   default(0.0), not null
#  fnqtyavail       :decimal(17, 5)   default(0.0), not null
#  fnreord          :decimal(17, 5)   default(0.0), not null
#  fnsafety         :decimal(17, 5)   default(0.0), not null
#  fnunitcost       :decimal(17, 5)   default(0.0), not null
#  fnnetavail       :decimal(17, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fnonnetqty       :decimal(15, 5)   default(0.0), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::PurchaseQueueSummary < M2m::Base
  self.table_name = 'pqsumm'
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
    @note = Production::PurchaseQueueNote.new(:part_number => self.part_number, :revision => self.revision)
  end
  scope :for_note, -> (note) {
    where :fcpartno => note.part_number, :fcpartrev => note.revision
  }
  
  scope :by_due_date, -> { order(:fdduedate) }
end
