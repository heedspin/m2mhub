# == Schema Information
#
# Table name: rcinsp
#
#  fcreceiver       :string(6)        default(""), not null
#  fcitemno         :string(3)        default(""), not null
#  fcpartno         :string(25)       default(""), not null
#  fcpartrev        :string(3)        default(""), not null
#  fdinspdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcinspby         :string(3)        default(""), not null
#  fcinspcode       :string(4)        default(""), not null
#  fnqtypass        :decimal(15, 5)   default(0.0), not null
#  fnqtyfail        :decimal(15, 5)   default(0.0), not null
#  flreturn         :boolean          default(FALSE), not null
#  flreorder        :boolean          default(FALSE), not null
#  fnqtyactd        :decimal(15, 5)   default(0.0), not null
#  fcnewloc         :string(14)       default(""), not null
#  fcnewbin         :string(14)       default(""), not null
#  fclot            :string(20)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmcomments       :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
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
