class M2m::Rma < M2m::Base
  set_table_name 'syrmama'
  set_primary_key 'fcrmano'
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

  scope :between, lambda { |start_date, end_date|
    { 
      :conditions => [ 'syrmama.fdenterdate >= ? and syrmama.fdenterdate < ?', start_date, end_date ]
    }
  }
  
  scope :with_rma_numbers, lambda { |rma_numbers|
    {
      :conditions => [ 'syrmama.fcrmano in (?)', rma_numbers ]
    }
  }
  
  # This works:
  # select * from syrmama where fcrmano = 85
  #
  # This does not:
  # select * from syrmama where fcrmano = N'85'  
  def self.find(*args)
    if (args.size == 1) and (id = args.first) and (id.is_a?(Fixnum) or id.is_a?(String))
      self.find(:first, :conditions => { :fcrmano => id.to_i })
    else
      super
    end
  end
  
  # def self.zero_pad(id)
  #   # 000000000000005    
  #   "%010d" % id
  # end

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
  
  def self.import_credit_memo_references
    self.all.each do |rma|
      if rma.credit_memo_reference.present?
        if rma.credit_memo_reference.no_credit_memo?
          puts "Rma #{rma.rma_number} has disabled credit memo reference"
        else
          if rma.items.all.size != 1
            puts "**** Too many rma items #{rma.items.all.size}"
          else
            rma_item = rma.items.first
            puts "Updating rma #{rma.rma_number} for #{rma_item.part_number} with credit memo reference: #{rma.credit_memo_reference}"
            invoice = M2m::Invoice.find(rma.credit_memo_reference.db_invoice_number)
            invoice_items = invoice.items.all.select { |ii| ii.part_number == rma_item.part_number }
            invoice_items.each do |invoice_item|
              if invoice_item.rma_key.present?
                puts "**** Invoice #{invoice_item.invoice_number} item #{invoice_item.item_number} has an existing rma_key #{invoice_item.rma_key}"
              else
                invoice_item.rma_item = rma_item
                if invoice_item.changes.size != 1
                  puts "**** Too many changes.  Not setting invoice #{invoice_item.invoice_number} item #{invoice_item.item_number} rma_key to #{invoice_item.rma_key}"              
                  puts "**** Too many changes.  Not saving."
                else
                  puts "     Setting invoice #{invoice_item.invoice_number} item #{invoice_item.item_number} rma_key to #{invoice_item.rma_key}"              
                  # invoice_item.save
                end
              end
            end
          end
        end
      end
    end
    puts "Done"
  end
  
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
    def to_s
      self.encode
    end
    def db_invoice_number
      M2m::Invoice.invoice_number(M2m::InvoiceType.credit_memo, self.invoice_number[/\d+/])
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
      if @ticket.nil?
        begin
          @ticket = Lighthouse::Ticket.find(@ticket_id, :params => { :project_id => CompanyConfig.lighthouse_rma_project_id })
        rescue ActiveResource::ResourceNotFound
          # Bad link...
        end
      end
      @ticket
    end
  end

  def lighthouse_ticket_reference
    @lighthouse_ticket_reference ||= LighthouseTicketReference.from(self.company_codes)
  end
  
  def lighthouse_ticket
    self.lighthouse_ticket_reference.try(:ticket)
  end
  
  # Console hint:
  # rma = M2m::Rma.find(119) ; rma.set_lighthouse_ticket_id(78) ; rma.save
  def set_lighthouse_ticket_id(ticket_id)
    @lighthouse_ticket_reference = LighthouseTicketReference.new(ticket_id)
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
