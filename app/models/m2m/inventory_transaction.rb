class M2m::InventoryTransaction < M2m::Base
  set_table_name 'intran'
  
  belongs_to_item :fpartno, :fcpartrev
  
  def transaction_type
    M2m::InventoryTransactionType.find_by_key(self.ftype)
  end
  
  alias_attribute :quantity, :fqty
  alias_attribute :date, :fdate
  alias_attribute :comment, :fcomment
  
  # "WHERE intran.ftoso = (sorels.fsono + sorels.finumber + sorels.frelease) " + ;
	
end

# == Schema Information
#
# Table name: intran
#
#  fdate            :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fpartno          :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  ftype            :string(1)       default(""), not null
#  faccno           :string(25)      default(""), not null
#  fcode            :string(4)       default(""), not null
#  fcost            :decimal(17, 5)  default(0.0), not null
#  ffrombin         :string(14)      default(""), not null
#  ffromexpdt       :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ffromjob         :string(10)      default(""), not null
#  ffromloc         :string(14)      default(""), not null
#  ffromlot         :string(20)      default(""), not null
#  finspect         :string(3)       default(""), not null
#  flabor           :decimal(17, 5)  default(0.0), not null
#  fmatl            :decimal(17, 5)  default(0.0), not null
#  fnumber          :integer(4)      default(0), not null
#  fovrhd           :decimal(17, 5)  default(0.0), not null
#  fqty             :decimal(15, 5)  default(0.0), not null
#  ftobin           :string(14)      default(""), not null
#  ftoexpdt         :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftojob           :string(10)      default(""), not null
#  ftoloc           :string(14)      default(""), not null
#  ftolot           :string(20)      default(""), not null
#  ftoso            :string(12)      default(""), not null
#  fctime_ts        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnnewonhd        :decimal(17, 5)  default(0.0), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fcomment         :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  ffromfac         :string(20)      default(""), not null
#  ftofac           :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
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
#  fuserinfo        :string(10)      default(""), not null
#

