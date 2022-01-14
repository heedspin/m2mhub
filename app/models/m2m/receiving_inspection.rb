# == Schema Information
#
# Table name: rcinsp
#
#  fcreceiver       :varchar(10)      default(""), not null
#  fcitemno         :char(3)          default("   "), not null
#  fcpartno         :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  fdinspdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcinspby         :char(3)          default("   "), not null
#  fcinspcode       :char(4)          default("    "), not null
#  fnqtypass        :decimal(15, 5)   default(0.0), not null
#  fnqtyfail        :decimal(15, 5)   default(0.0), not null
#  flreturn         :boolean          default(FALSE), not null
#  flreorder        :boolean          default(FALSE), not null
#  fnqtyactd        :decimal(15, 5)   default(0.0), not null
#  fcnewloc         :char(14)         default("              "), not null
#  fcnewbin         :char(14)         default("              "), not null
#  fclot            :varchar(50)      default(""), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmcomments       :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  returnisono      :varchar(10)      default(""), not null
#  fnqtytoship      :decimal(15, 5)   default(0.0), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::ReceivingInspection < M2m::Base
  self.table_name = 'rcinsp'
  alias_attribute :receiver_number, :fcreceiver
  alias_attribute :item_number, :fcitemno
  belongs_to_item :fcpartno, :fcpartrev
  alias_attribute :inspection_date, :fdinspdate
  alias_attribute :quantity_passed, :fnqtypass
  alias_attribute :quantity_failed, :fnqtyfail
  alias_attribute :comments, :fmcomments
end
