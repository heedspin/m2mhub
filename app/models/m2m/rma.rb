class M2m::Rma < M2m::Base
  set_table_name 'syrmama'
  set_primary_key 'fcrmano'
  belongs_to :inquiry, :class_name => 'M2m::Inquiry', :foreign_key => :finqno, :primary_key => :InquiryNo
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fccustno, :primary_key => :fcustno

  alias_attribute :user_defined1, :fcusrchr1
  alias_attribute :user_defined2, :fcusrchr2
  alias_attribute :user_defined3, :fcusrchr3
  alias_attribute :enter_date, :fdenterdate
  alias_attribute :date, :fdenterdate
  alias_attribute :customer_number, :fccustno
  alias_attribute :severity_code, :fcseverty

  def rma_number
    self.fcrmano.to_i
  end

  def company_rma_number
    if CompanyConfig.rma_company_rma_number_field == 'fcrmano'
      self.rma_number
    else
      self.send(CompanyConfig.rma_company_rma_number_field)
    end
  end  

  def status
    M2m::Status.find_by_name(self.fcstatus)
  end
  def open?
    self.status.try(:open?)
  end

  def company_codes
    self.send(CompanyConfig.rma_custom_codes_field)
  end
  def company_codes=(val)
    self.send(CompanyConfig.rma_custom_codes_field + '=', val)
  end

  def severity
    M2m::CsPopup.cached_lookup('SYRMAMA.FCSEVERTY', self.fcseverty)
  end
  def severity_name
    self.severity.try(:text).try(:strip)
  end
  
  # def self.import_company_codes
  #   self.all.each do |rma|
  #     codes = []
  #     if rma.user_defined1.present?
  #       old_cm = rma.user_defined1.strip
  #       if old_cm.downcase.starts_with?('cm-')
  #         codes.push old_cm
  #       elsif old_cm =~ /\w*^N\/?A$\w*/
  #         codes.push 'CM-None'     
  #       end
  #     end
  #     if codes.size > 0
  #       rma.company_codes = codes.join(', ')
  #     end
  #     unless %w(Q S O C).include?(rma.severity_code)
  #       rma.severity_code = rma.inquiry.try(:category_code)
  #     end
  #     if rma.changed?
  #       puts "Updating rma #{rma.rma_number}: #{rma.changes.inspect}"
  #       # rma.save
  #     end
  #   end
  #   puts "Done"
  # end
  
  # **********************************************************************

  class CreditMemoReference
    def self.from(company_codes)
      return nil unless company_codes.present?
      # TODO: Allow for CM-NONE or something.
      if company_codes =~ /(credit|credit ?memo|cm)\W+(\w+)/i
        self.new($2)
      end
    end
    attr_accessor :invoice_number
    def initialize(thing)
      if thing.to_i.to_s == thing
        @invoice_number = thing
      else
        @invoice_number = 'None'
      end
    end
    def encode
      "CM-#{self.invoice_number}"
    end
    def no_credit_memo?
      self.invoice_number == 'None'
    end
  end
  
  def credit_memo_reference
    @credit_memo_reference ||= CreditMemoReference.from(self.company_codes)
  end
  
  # **********************************************************************

  class LighthouseTicketReference
    def self.from(company_codes)
      return nil unless company_codes.present?
      if company_codes =~ /(lighthouse|lh|ticket)\W*(\d+)/i
        self.new($2)
      end
    end
    attr_accessor :ticket_id
    def initialize(ticket_id)
      @ticket_id = ticket_id
    end
    def encode
      "ticket-#{self.ticket_id}"
    end
    def ticket
      @ticket ||= Lighthouse::Ticket.find(@ticket_id, :params => { :project_id => CompanyConfig.lighthouse_rma_project_id })
    end
  end

  def lighthouse_ticket_reference
    @lighthouse_ticket_reference ||= LighthouseTicketReference.from(self.company_codes)
  end  
  
  # **********************************************************************

  protected

    before_save :encode_company_codes
    def encode_company_codes
      self.company_codes = [ self.credit_memo_reference, self.lighthouse_ticket_reference ].compact.map(&:encode).join(', ')      
    end
    
end

# == Schema Information
#
# Table name: syrmama
#
#  fcrmano          :string(25)      default(""), not null
#  fcsono           :string(6)       default(""), not null
#  fccustno         :string(6)       default(""), not null
#  fcstatus         :string(20)      default(""), not null
#  fcenterby        :string(3)       default(""), not null
#  fcauthby         :string(3)       default(""), not null
#  fcseverty        :string(1)       default(""), not null
#  fccustpo         :string(20)      default(""), not null
#  fcsalecode       :string(7)       default(""), not null
#  fdincidate       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fdenterdate      :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  finqno           :string(6)       default(""), not null
#  fcompany         :string(35)      default(""), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fnextenum        :string(3)       default(""), not null
#  fnextinum        :string(3)       default(""), not null
#  fcfname          :string(20)      default(""), not null
#  fcusrchr1        :string(40)      default(""), not null
#  fcusrchr2        :string(40)      default(""), not null
#  fcusrchr3        :string(40)      default(""), not null
#  fnusrqty1        :decimal(15, 5)  default(0.0), not null
#  fnusrcur1        :decimal(17, 5)  default(0.0), not null
#  fdusrdate1       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fmusrmemo1       :text            default(""), not null
#  fnotes           :string(500)     default(""), not null
#  flfsflag         :boolean         default(FALSE), not null
#  fcontact         :string(30)      default(""), not null
#  fdisrate         :decimal(8, 3)   default(0.0), not null
#  fcusrchr4        :string(40)      default(""), not null
#
