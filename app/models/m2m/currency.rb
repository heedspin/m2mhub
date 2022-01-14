# == Schema Information
#
# Table name: utcurr
#
#  flemu            :boolean
#  fccountry        :string(25)
#  fccurid          :string(3)
#  fccurname        :string(35)
#  fcfamount        :string(20)
#  fcdatefor        :string(10)
#  fcdatemar        :string(1)
#  fcdsep           :string(1)
#  fcfcostpr        :string(20)
#  fcfnumber        :string(20)
#  fcforder         :string(20)
#  fcfphone         :string(20)
#  fcfstate         :string(20)
#  fcftotamt        :string(25)
#  fcftotnum        :string(25)
#  fcfzip           :string(20)
#  fcsetcent        :string(3)
#  fcsymbol         :nchar(6)         not null
#  fctsep           :string(1)
#  fndefault        :integer
#  fnnegamt         :integer
#  fnnegnum         :integer
#  fnnumdec         :integer
#  fnsymbol         :integer
#  fcssn            :string(15)
#  fnnumunitdec     :integer
#  fcdeccurr        :string(35)
#  fcdecsym         :nchar(6)         not null
#  fclang           :string(8)
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fcisocurid       :char(3)          not null
#  flziprqd         :boolean          not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Currency < M2m::Base
  self.table_name = 'utcurr'
  
  def country_name
    self.FCCOUNTRY.strip
  end
end
