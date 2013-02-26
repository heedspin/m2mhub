# == Schema Information
#
# Table name: sycslm
#
#  fcinqno          :string(6)        default(""), not null, primary key
#  fcsono           :string(6)        default(""), not null
#  fcpartno         :string(25)       default(""), not null
#  fcpartrev        :string(3)        default(""), not null
#  fdinqdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fctype           :string(1)        default(""), not null
#  fcstatus         :string(20)       default(""), not null
#  fcenterby        :string(3)        default(""), not null
#  fcauthby         :string(3)        default(""), not null
#  fccustomer       :string(35)       default(""), not null
#  fcvendor         :string(35)       default(""), not null
#  fcphone          :string(20)       default(""), not null
#  fcrmano          :string(25)       default(""), not null
#  fcassignto       :string(3)        default(""), not null
#  fdestdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcreslvby        :string(3)        default(""), not null
#  fdreslvdat       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcrevwby         :string(3)        default(""), not null
#  fdrevwdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcusrchr1        :string(40)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fcusrchr4        :string(40)       default(""), not null
#  fnusrqty1        :decimal(17, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fccustno         :string(6)        default(""), not null
#  fcvendno         :string(6)        default(""), not null
#  fcseverity       :string(1)        default(""), not null
#  fccategory       :string(1)        default(""), not null
#  fcclass          :string(1)        default(""), not null
#  fcrinscode       :string(4)        default(""), not null
#  fcpono           :string(6)        default(""), not null
#  fcfax            :string(20)       default(""), not null
#  fcemail          :string(60)       default(""), not null
#  fnqty            :decimal(17, 5)   default(0.0), not null
#  fcfname          :string(15)       default(""), not null
#  fclname          :string(20)       default(""), not null
#  fccustpo         :string(20)       default(""), not null
#  fcsalecode       :string(7)        default(""), not null
#  fccuststat       :string(1)        default(""), not null
#  fcnextact        :string(1)        default(""), not null
#  fcother          :string(1)        default(""), not null
#  fcmeasure        :string(3)        default(""), not null
#  fcother2         :string(20)       default(""), not null
#  fclot            :string(20)       default(""), not null
#  fdincidate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcwlitem         :string(6)        default(""), not null
#  finumber         :string(3)        default(""), not null
#  frelsno          :string(3)        default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fminquiry        :text             default(""), not null
#  fmusrmemo1       :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
#

class M2m::CustomerServiceLog < M2m::Base
  set_table_name 'sycslm'
  set_primary_key 'fcinqno'

  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fcsono
  belongs_to_item :fcpartno, :fcpartrev
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fccustno, :primary_key => :fcustno

  scope :status_open,      :conditions => { :fcstatus => M2m::Status.open.name }
  scope :status_closed,    :conditions => { :fcstatus => M2m::Status.closed.name }
  scope :status_cancelled, :conditions => { :fcstatus => M2m::Status.cancelled.name }
  scope :between, lambda { |start_date, end_date|
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
  alias_attribute :user_defined2, :fcusrchr2
  alias_attribute :customer_name, :fccustomer
  alias_attribute :customer_number, :fccustno
  alias_attribute :sales_order_number, :fcsono

  def rma_number
    self.fcrmano.strip
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
  
  def invoice_number=(val)
    write_attribute(:invoice_number, val)
  end
  def invoice_total=(val)
    write_attribute(:invoice_total, val)
  end
  def invoice_date=(val)
    write_attribute(:invoice_date, val)
  end
  
  def lighthouse_ticket
    if @lighthouse_ticket.nil?
      if self.user_defined2.present? and (self.user_defined2 =~ /(lighthouse|lh|ticket)\W*(\d+)/i)
        ticket_id = $2
        @lighthouse_ticket = Lighthouse::Ticket.find(ticket_id, :params => { :project_id => AppConfig.lighthouse_customer_service_project_id })
      end
    end
    @lighthouse_ticket
  end
  
end
