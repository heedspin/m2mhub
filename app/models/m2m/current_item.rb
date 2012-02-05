class M2m::CurrentItem < M2m::Base
  set_table_name 'invcur'
  belongs_to_item :fcpartno, :fcpartrev
  scope :for_part_number, lambda { |pn| 
    {
      :conditions => { :fcpartno => pn.strip, :flanycur => true }
    } 
  }
  def is_item?(item)
    item.revision.strip == self.revision
  end
end

# == Schema Information
#
# Table name: invcur
#
#  fcpartno         :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  flanycur         :boolean         default(FALSE), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#

