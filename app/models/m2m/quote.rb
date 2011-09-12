class M2m::Quote < M2m::Base
  set_table_name 'qtmast'
  
  has_many :items, :class_name => 'M2m::QuoteItem', :foreign_key => :fquoteno, :primary_key => :fquoteno
  
  named_scope :open,      :conditions => { :fstatus => M2m::Status.open.name }
  named_scope :closed,    :conditions => { :fstatus => M2m::Status.closed.name }
  named_scope :cancelled, :conditions => { :fstatus => M2m::Status.cancelled.name }
  
  def terms
    M2m::Terms.find_by_key(self.fterm.try(:strip))
  end
  
  alias_attribute :discount_rate, :fdisrate
end

# == Schema Information
#
# Table name: qtmast
#
#  fcompany         :string(35)      default(" "), not null
#  fquoteno         :string(6)       not null
#  fackdate         :datetime        not null
#  fccurid          :string(3)       not null
#  fcfactor         :decimal(17, 5)  not null
#  fcfname          :string(15)      not null
#  fcfromno         :string(6)       not null
#  fcfromtype       :string(5)       not null
#  fcity            :string(20)      not null
#  fcountry         :string(25)      not null
#  fdatedue         :datetime        not null
#  fdaterecvd       :datetime        not null
#  fdcurdate        :datetime        not null
#  fdexpired        :datetime        not null
#  fdistno          :string(6)       not null
#  fdsalespn        :string(25)      not null
#  fduplicate       :boolean         not null
#  festimator       :string(3)       not null
#  ffax             :string(20)      not null
#  fjobname         :string(65)      default(" "), not null
#  fcsoldto         :string(4)       not null
#  fcustno          :string(6)       not null
#  fnextenum        :string(3)       not null
#  fnextinum        :string(3)       not null
#  fordpotent       :string(1)       not null
#  fordtime         :string(1)       not null
#  fphone           :string(20)      not null
#  fprint_dt        :datetime        not null
#  fprinted         :boolean         not null
#  fquotecopy       :string(1)       not null
#  fquotedate       :datetime        not null
#  fquoteto         :string(20)      not null
#  frequestno       :string(15)      not null
#  frevno           :string(2)       not null
#  fsalespn         :string(3)       not null
#  fstate           :string(20)      not null
#  fstatus          :string(20)      not null
#  ftype            :string(1)       not null
#  fzip             :string(10)      not null
#  fcusrchr1        :string(20)      not null
#  fcusrchr2        :string(40)      default(" "), not null
#  fcusrchr3        :string(40)      default(" "), not null
#  fnusrqty1        :decimal(15, 5)  not null
#  fnusrcur1        :decimal(17, 5)  not null
#  fdusrdate1       :datetime        not null
#  fdisrate         :decimal(15, 5)  not null
#  fterm            :string(4)       not null
#  fpaytype         :string(1)       not null
#  fdeurodate       :datetime        not null
#  feurofctr        :decimal(17, 5)  not null
#  fusercode        :string(7)       not null
#  fcshipto         :string(4)       not null
#  fltotal          :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fclosmemo        :text            default(" "), not null
#  fmstreet         :text            default(" "), not null
#  fmusermemo       :text            default(" "), not null
#  fsalumemo        :text            default(" "), not null
#  fccontkey        :string(10)      default(" "), not null
#  flcontract       :boolean         default(FALSE), not null
#  fndbrmod         :integer(1)      not null
#

