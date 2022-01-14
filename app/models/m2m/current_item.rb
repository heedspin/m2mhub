# == Schema Information
#
# Table name: invcur
#
#  fcpartno         :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  flanycur         :boolean          default(FALSE), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::CurrentItem < M2m::Base
  self.table_name = 'invcur'
  belongs_to_item :fcpartno, :fcpartrev
  scope :for_part_number, -> (pn) {
    where :fcpartno => pn.strip, :flanycur => true
  }
  def is_item?(item)
    item.revision.strip == self.revision
  end
end
