class M2m::CustomerServiceLog < M2m::Base
  set_table_name 'sycslm'
  set_primary_key 'fcinqno'

  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fcsono
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fcpartno, :fcpartrev]
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fccustno, :primary_key => :fcustno

  named_scope :open,      :conditions => { :fcstatus => M2m::Status.open.name }
  named_scope :closed,    :conditions => { :fcstatus => M2m::Status.closed.name }
  named_scope :cancelled, :conditions => { :fcstatus => M2m::Status.cancelled.name }
  named_scope :between, lambda { |start_date, end_date|
    { 
      :conditions => [ 'sycslm.fdinqdate >= ? and sycslm.fdinqdate < ?', start_date, end_date ]
    }
  }

  def status
    M2m::Status.find_by_name(self.fcstatus)
  end
  def open?
    self.status.try(:open?)
  end
    
  alias_attribute :date, :fdinqdate
  alias_attribute :quantity, :fnqty
  alias_attribute :inquiry, :fminquiry
  alias_attribute :inquiry_number, :fcinqno
  alias_attribute :category_code, :fccategory
  alias_attribute :user_defined1, :fcusrchr1
  alias_attribute :customer_name, :fccustomer
  alias_attribute :customer_number, :fccustno
  alias_attribute :sales_order_number, :fcsono

  def rma_number
    self.fcrmano.strip
  end
  
  def company_rma_number
    # TODO: Make this configurable.
    self.other2
  end
  
  def credit_memo_reference
    # TODO: Make this configurable.
    self.user_defined1
  end
  
  def other2
    self.fcother2.strip
  end
  
  def category
    M2m::CsPopup.cached_lookup('SYCSLM.FCCATEGORY', self.category_code)
  end
  def category_name
    self.category.try(:text)
  end
  
  def part_number
    @part_number ||= self.fcpartno.strip
  end

  def revision
    @revision ||= self.fcpartrev.strip
  end
  
  def invoice_number=(val)
    write_attribute(:invoice_number, val)
  end
  def invoice_total=(val)
    write_attribute(:invoice_total, val)
  end
  def invoice_date=(val)
    write_attribute(:invoice_date, val)
  end
  
end
# == Schema Information
#
# Table name: sycslm
#
#  fcinqno          :string(6)       not null, primary key
#  fcsono           :string(6)       not null
#  fcpartno         :string(25)      not null
#  fcpartrev        :string(3)       not null
#  fdinqdate        :datetime        not null
#  fctype           :string(1)       not null
#  fcstatus         :string(20)      not null
#  fcenterby        :string(3)       not null
#  fcauthby         :string(3)       not null
#  fccustomer       :string(35)      default(" "), not null
#  fcvendor         :string(35)      default(" "), not null
#  fcphone          :string(20)      not null
#  fcrmano          :string(25)      not null
#  fcassignto       :string(3)       not null
#  fdestdate        :datetime        not null
#  fcreslvby        :string(3)       not null
#  fdreslvdat       :datetime        not null
#  fcrevwby         :string(3)       not null
#  fdrevwdate       :datetime        not null
#  fcusrchr1        :string(40)      default(" "), not null
#  fcusrchr2        :string(40)      default(" "), not null
#  fcusrchr3        :string(40)      default(" "), not null
#  fcusrchr4        :string(40)      default(" "), not null
#  fnusrqty1        :decimal(17, 5)  not null
#  fnusrcur1        :decimal(, )     not null
#  fdusrdate1       :datetime        not null
#  fccustno         :string(6)       not null
#  fcvendno         :string(6)       not null
#  fcseverity       :string(1)       not null
#  fccategory       :string(1)       not null
#  fcclass          :string(1)       not null
#  fcrinscode       :string(4)       not null
#  fcpono           :string(6)       not null
#  fcfax            :string(20)      not null
#  fcemail          :string(60)      default(" "), not null
#  fnqty            :decimal(17, 5)  not null
#  fcfname          :string(15)      not null
#  fclname          :string(20)      not null
#  fccustpo         :string(20)      not null
#  fcsalecode       :string(7)       not null
#  fccuststat       :string(1)       not null
#  fcnextact        :string(1)       not null
#  fcother          :string(1)       not null
#  fcmeasure        :string(3)       not null
#  fcother2         :string(20)      not null
#  fclot            :string(20)      not null
#  fdincidate       :datetime        not null
#  fcwlitem         :string(6)       not null
#  finumber         :string(3)       not null
#  frelsno          :string(3)       not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fminquiry        :text            default(" "), not null
#  fmusrmemo1       :text            default(" "), not null
#  fac              :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#

