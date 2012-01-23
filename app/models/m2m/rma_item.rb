class M2m::RmaItem < M2m::Base
  set_table_name 'syrmaitm'
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fcpartno, :fcpartrev]  
  belongs_to :rma, :class_name => 'M2m::Rma', :foreign_key => 'fcrmano', :primary_key => 'fcrmano'
  has_many :vendors, :class_name => 'M2m::InventoryVendor', :foreign_key => :fpartno, :primary_key => :fpartno

  alias_attribute :quantity, :fnqty
  alias_attribute :reason, :freason
  
  def rma_number
    self.fcrmano.to_i
  end
  
  def item_number
    self.finumber.strip
  end

  def part_number
    @part_number ||= self.fcpartno.strip
  end

  def revision
    @revision ||= self.fcpartrev.strip
  end
  
  def invoice_items
    @invoice_items ||= M2m::InvoiceItem.for_rma_item(self).all
  end
  def invoice_items=(invoice_items)
    @invoice_items = invoice_items
  end
  
  def invoice_amount
    self.invoice_items.sum(&:amount)
  end
  
end

# == Schema Information
#
# Table name: syrmaitm
#
#  fcrmano          :string(25)      default(""), not null
#  fcpartno         :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  fac              :string(20)      default(""), not null
#  fnqty            :decimal(17, 5)  default(0.0), not null
#  fdesc            :string(35)      default(""), not null
#  fcinstruct       :string(2)       default(""), not null
#  fmeasure         :string(3)       default(""), not null
#  fdiscper         :decimal(, )     default(0.0), not null
#  fdiscamt         :decimal(, )     default(0.0), not null
#  frestockper      :decimal(, )     default(0.0), not null
#  funitprice       :decimal(, )     default(0.0), not null
#  finspect         :string(1)       default(""), not null
#  fsource          :string(1)       default(""), not null
#  fncharge         :decimal(, )     default(0.0), not null
#  fnitotalcr       :decimal(, )     default(0.0), not null
#  fnqtycr          :decimal(17, 5)  default(0.0), not null
#  fnqtyrecd        :decimal(17, 5)  default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fenumber         :string(3)       default(""), not null
#  finumber         :string(3)       default(""), not null
#  fnextinum        :integer(4)      default(0), not null
#  fclot            :string(20)      default(""), not null
#  fcinscode        :string(4)       default(""), not null
#  freason          :text            default(""), not null
#  fnMiscAmt        :decimal(, )     default(0.0), not null
#  fcudrev          :string(3)       default(""), not null
#  fcudinstrc       :text            default(""), not null
#  fcsokey          :string(12)      default(""), not null
#  finqno           :string(6)       default(""), not null
#

