# == Schema Information
#
# Table name: sycslm
#
#  fcinqno          :varchar(10)      default(""), not null, primary key
#  fcsono           :varchar(10)      default(""), not null
#  fcpartno         :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  fdinqdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fctype           :char(1)          default(" "), not null
#  fcstatus         :char(20)         default("                    "), not null
#  fcenterby        :char(3)          default("   "), not null
#  fcauthby         :char(3)          default("   "), not null
#  fccustomer       :varchar(35)      default(""), not null
#  fcvendor         :varchar(35)      default(""), not null
#  fcphone          :char(20)         default("                    "), not null
#  fcrmano          :char(25)         default("                         "), not null
#  fcassignto       :char(3)          default("   "), not null
#  fdestdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcreslvby        :char(3)          default("   "), not null
#  fdreslvdat       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcrevwby         :char(3)          default("   "), not null
#  fdrevwdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcusrchr1        :varchar(40)      default(""), not null
#  fcusrchr2        :varchar(40)      default(""), not null
#  fcusrchr3        :varchar(40)      default(""), not null
#  fcusrchr4        :varchar(40)      default(""), not null
#  fnusrqty1        :decimal(17, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccustno         :char(6)          default("      "), not null
#  fcvendno         :char(6)          default("      "), not null
#  fcseverity       :char(1)          default(" "), not null
#  fccategory       :char(1)          default(" "), not null
#  fcclass          :char(1)          default(" "), not null
#  fcrinscode       :char(4)          default("    "), not null
#  fcpono           :varchar(10)      default(""), not null
#  fcfax            :char(20)         default("                    "), not null
#  fcemail          :varchar(60)      default(""), not null
#  fnqty            :decimal(17, 5)   default(0.0), not null
#  fcfname          :char(15)         default("               "), not null
#  fclname          :char(20)         default("                    "), not null
#  fccustpo         :char(20)         default("                    "), not null
#  fcsalecode       :char(7)          default("       "), not null
#  fcnextact        :char(1)          default(" "), not null
#  fcother          :char(1)          default(" "), not null
#  fcmeasure        :char(3)          default("   "), not null
#  fcother2         :char(20)         default("                    "), not null
#  fclot            :varchar(50)      default(""), not null
#  fdincidate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcwlitem         :char(6)          default("      "), not null
#  finumber         :char(3)          default("   "), not null
#  frelsno          :char(3)          default("   "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null
#  fminquiry        :varchar_max(2147 default(""), not null
#  fmusrmemo1       :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fccuststat       :char(1)
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::CustomerServiceLog < M2m::Base
  self.table_name = 'sycslm'
  self.primary_key = 'fcinqno'

  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fcsono
  belongs_to_item :fcpartno, :fcpartrev
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fccustno, :primary_key => :fcustno

  scope :status_open,      -> { where(:fcstatus => M2m::Status.open.name) }
  scope :status_closed,    -> { where(:fcstatus => M2m::Status.closed.name) }
  scope :status_cancelled, -> { where(:fcstatus => M2m::Status.cancelled.name) }
  scope :between, -> (start_date, end_date) {
    where [ 'sycslm.fdinqdate >= ? and sycslm.fdinqdate < ?', start_date, end_date ]
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
