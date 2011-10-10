class M2m::InventoryTransaction < M2m::Base
  set_table_name 'intran'
  
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => :fpartno, :primary_key => :fpartno  
  
  def transaction_type
    M2m::InventoryTransactionType.find_by_key(self.ftype)
  end
  
  alias_attribute :quantity, :fqty
  alias_attribute :date, :fdate
  
  # "WHERE intran.ftoso = (sorels.fsono + sorels.finumber + sorels.frelease) " + ;
	
end
# == Schema Information
#
# Table name: intran
#
#  fdate            :datetime        not null
#  fpartno          :string(25)      not null
#  fcpartrev        :string(3)       not null
#  ftype            :string(1)       not null
#  faccno           :string(25)      not null
#  fcode            :string(4)       not null
#  fcost            :decimal(17, 5)  not null
#  ffrombin         :string(14)      not null
#  ffromexpdt       :datetime        not null
#  ffromjob         :string(10)      not null
#  ffromloc         :string(14)      not null
#  ffromlot         :string(20)      not null
#  finspect         :string(3)       not null
#  flabor           :decimal(17, 5)  not null
#  fmatl            :decimal(17, 5)  not null
#  fnumber          :integer         not null
#  fovrhd           :decimal(17, 5)  not null
#  fqty             :decimal(15, 5)  not null
#  ftobin           :string(14)      not null
#  ftoexpdt         :datetime        not null
#  ftojob           :string(10)      not null
#  ftoloc           :string(14)      not null
#  ftolot           :string(20)      not null
#  ftoso            :string(12)      not null
#  fctime_ts        :datetime        not null
#  fnnewonhd        :decimal(17, 5)  not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fcomment         :text            default(" "), not null
#  fac              :string(20)      not null
#  ffromfac         :string(20)      not null
#  ftofac           :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#  fiorigum         :integer(4)      default(0), not null
#  fium1            :integer(4)      default(0), not null
#  fium2            :integer(4)      default(0), not null
#  fium3            :integer(4)      default(0), not null
#  fium4            :integer(4)      default(0), not null
#  fium5            :integer(4)      default(0), not null
#  fiunitcnt        :integer(4)      default(0), not null
#  fnorigqty        :decimal(17, 5)  default(0.0), not null
#  fnqty1           :decimal(17, 5)  default(0.0), not null
#  fnqty2           :decimal(17, 5)  default(0.0), not null
#  fnqty3           :decimal(17, 5)  default(0.0), not null
#  fnqty4           :decimal(17, 5)  default(0.0), not null
#  fnqty5           :decimal(17, 5)  default(0.0), not null
#

