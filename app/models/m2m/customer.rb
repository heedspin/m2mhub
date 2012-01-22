class M2m::Customer < M2m::Base
  set_table_name 'slcdpm'
  set_primary_key 'fcustno'
  has_many :sales_orders, :class_name => 'M2m::SalesOrder', :foreign_key => :fcustno
  has_many :quotes, :class_name => 'M2m::Quote', :foreign_key => :fcustno

  alias_attribute :notes, :fmnotes
  alias_attribute :last_name, :fcontact
  alias_attribute :first_name, :fcfname
  alias_attribute :company_name, :fcompany
  alias_attribute :customer_number, :fcustno
  
  named_scope :name_like, lambda { |text|
    {
      :conditions => [ 'slcdpm.fcompany like ?', '%' + (text || '') + '%' ]
    }
  }
  
  named_scope :with_customer_numbers, lambda { |customer_numbers|
    {
      :conditions => [ 'slcdpm.fcustno in (?)', customer_numbers ]
    }
  }
  
  def status
    M2m::CustomerStatus.find_by_key(self.fcstatus)
  end

  def self.customer_name(txt)
    if (txt =~ /[a-z]/)
      txt
    else
      txt.split(' ').map { |p| p.downcase.capitalize }.join(' ')
    end
  end
  
  def name
    @name ||= M2m::Customer.customer_name(self.fcompany)
  end
  
  def self.all_names
    self.all(:select => 'slcdpm.fcompany', :order => 'slcdpm.fcompany').map(&:name)
  end  
  
  def fob
    self.ffob.strip
  end
end



# == Schema Information
#
# Table name: slcdpm
#
#  fcustno          :string(6)       not null, primary key
#  fcompany         :string(35)      not null
#  fcity            :string(20)      not null
#  fphone           :string(20)      not null
#  fann_sales       :integer(4)      not null
#  fbacklog         :decimal(16, 4)  not null
#  fbalnxt          :decimal(17, 5)  not null
#  fcfname          :string(15)      not null
#  fcontact         :string(20)      not null
#  fcountry         :string(25)      not null
#  fcreated         :datetime        not null
#  fcrlimit         :integer(4)      not null
#  fcshipto         :string(4)       not null
#  fcsoldto         :string(4)       not null
#  fcurrency        :string(3)       not null
#  fcusrchr1        :string(20)      not null
#  fcusrchr2        :string(40)      not null
#  fcusrchr3        :string(40)      not null
#  fdbdate          :datetime        not null
#  fdbrate          :string(4)       not null
#  fdisrate         :decimal(8, 3)   not null
#  fdistno          :string(6)       not null
#  fdusrdate1       :datetime        not null
#  fllongdist       :boolean         not null
#  ffax             :string(20)      not null
#  ffincharge       :boolean         not null
#  ffob             :string(20)      not null
#  fmtdamtnxt       :decimal(17, 5)  not null
#  fmtdsamt         :decimal(17, 5)  not null
#  fnardayslt       :decimal(17, 5)  not null
#  fno_employ       :integer(4)      not null
#  fcpaydex         :string(3)       not null
#  fnusrcur1        :decimal(17, 5)  not null
#  fnusrqty1        :decimal(15, 5)  not null
#  fpaytype         :string(1)       not null
#  fpriority        :string(2)       not null
#  fsalcompct       :decimal(8, 3)   not null
#  fsalespn         :string(3)       not null
#  fsicno1          :string(4)       not null
#  fsicno2          :string(4)       not null
#  fshipvia         :string(20)      not null
#  fsince           :datetime        not null
#  fstate           :string(20)      not null
#  ftaxcode         :string(10)      not null
#  ftaxexempt       :string(15)      not null
#  ftaxrate         :decimal(7, 3)   not null
#  fterm            :string(4)       not null
#  fterr            :string(10)      not null
#  ftype            :string(1)       not null
#  fusercode        :string(7)       not null
#  fytdsamt         :decimal(16, 4)  not null
#  fyr_estab        :string(4)       not null
#  fzip             :string(10)      not null
#  fcstatus         :string(1)       not null
#  flistaxabl       :boolean         not null
#  fcemail          :string(60)      not null
#  flisfcast        :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fbus_type        :text            not null
#  fmnotes          :text            not null
#  fmstreet         :text            not null
#  fmusrmemo1       :text            not null
#  fncrmmod         :integer(4)      not null
#  fccrmacct        :string(12)      not null
#  fscmprty         :integer(4)      not null
#  fdisttype        :string(10)      not null
#  SubType          :string(15)      not null
#  flEdited         :boolean         not null
#  fURL             :string(255)     not null
#  ContactNum       :string(6)       not null
#  HomePhone        :string(20)      not null
#  MobilePhone      :string(20)      not null
#  NAICsCode        :string(6)       not null
#  fdlpaydate       :datetime
#  fnpayamt         :decimal(17, 5)
#  fcurorder        :decimal(17, 5)
#  fytdSales        :decimal(17, 5)
#  fmtdSales        :decimal(17, 5)
#  fbal             :decimal(, )
#  fopencr          :decimal(, )
#

