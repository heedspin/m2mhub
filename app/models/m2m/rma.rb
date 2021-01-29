# == Schema Information
#
# Table name: syrmama
#
#  fcrmano          :string(25)       default(""), not null, primary key
#  fcsono           :string(6)        default(""), not null
#  fccustno         :string(6)        default(""), not null
#  fcstatus         :string(20)       default(""), not null
#  fcenterby        :string(3)        default(""), not null
#  fcauthby         :string(3)        default(""), not null
#  fcseverty        :string(1)        default(""), not null
#  fccustpo         :string(20)       default(""), not null
#  fcsalecode       :string(7)        default(""), not null
#  fdincidate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdenterdate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  finqno           :string(6)        default(""), not null
#  fcompany         :string(35)       default(""), not null
#  identity_column  :integer          not null
#  timestamp_column :binary
#  fnextenum        :string(3)        default(""), not null
#  fnextinum        :string(3)        default(""), not null
#  fcfname          :string(20)       default(""), not null
#  fcusrchr1        :string(40)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmusrmemo1       :text             default(""), not null
#  fnotes           :string(500)      default(""), not null
#  flfsflag         :boolean          default(FALSE), not null
#  fcontact         :string(30)       default(""), not null
#  fdisrate         :decimal(8, 3)    default(0.0), not null
#  fcusrchr4        :string(40)       default(""), not null
#

class M2m::Rma < M2m::Base
  self.table_name = 'syrmama'
  self.primary_key = 'fcrmano'
  belongs_to :inquiry, :class_name => 'M2m::Inquiry', :foreign_key => :finqno, :primary_key => :InquiryNo
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fccustno, :primary_key => :fcustno
  has_many :items, :class_name => 'M2m::RmaItem', :foreign_key => 'fcrmano', :primary_key => 'fcrmano'

  alias_attribute :user_defined1, :fcusrchr1
  alias_attribute :user_defined2, :fcusrchr2
  alias_attribute :user_defined3, :fcusrchr3
  alias_attribute :enter_date, :fdenterdate
  alias_attribute :date, :fdenterdate
  alias_attribute :customer_number, :fccustno
  alias_attribute :customer_name, :fcompany
  alias_attribute :severity_code, :fcseverty
  alias_attribute :sales_order_number, :fcsono
  alias_attribute :padded_rma_number, :fcrmano

  scope :between, -> (start_date, end_date) {
    where [ 'syrmama.fdenterdate >= ? and syrmama.fdenterdate < ?', start_date, end_date ]
  }

  scope :with_rma_numbers, -> (rma_numbers) {
    where [ 'syrmama.fcrmano in (?)', rma_numbers ]
  }

  def self.closed
    where fcstatus: 'CLOSED'
  end

  attr_accessor :inspection_task
  def inspection_task
    if @inspection_task.nil?
      @inspection_task = Quality::InspectionTask.rma_number(self.rma_number).first
      @inspection_task = false if @inspection_task.nil?
    end
    # This trickery allows us to set the inspection_task to false and keep it from trying to load.
    @inspection_task.is_a?(FalseClass) ? nil : @inspection_task
  end

  # This works:
  # select * from syrmama where fcrmano = 85
  #
  # This does not:
  # select * from syrmama where fcrmano = N'85'
  def self.find(*args)
    if (args.size == 1) and (id = args.first) and (id.is_a?(Fixnum) or id.is_a?(String))
      self.where(:fcrmano => id.to_i).first
    else
      super
    end
  end

  def self.pad_rma_number(number)
    # 000000000000005
    "%015d" % number.to_i
  end

  def rma_number
    @rma_number ||= self.fcrmano.to_i
  end

  def company_rma_number
    if AppConfig.rma_company_rma_number_field == 'fcrmano'
      self.rma_number
    else
      self.send(AppConfig.rma_company_rma_number_field)
    end
  end

  def status
    M2m::Status.find_by_name(self.fcstatus)
  end
  def open?
    self.status.try(:open?)
  end

  def severity
    M2m::CsPopup.cached_lookup('SYRMAMA.FCSEVERTY', self.fcseverty)
  end
  def severity_name
    self.severity.try(:text).try(:strip)
  end

  # Deprecated ------------------------------------------------

  def company_codes
    self.send(AppConfig.rma_custom_codes_field)
  end

end
