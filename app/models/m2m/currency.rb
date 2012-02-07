# == Schema Information
#
# Table name: utcurr
#
#  FCCOUNTRY        :string(25)      not null
#  FCCURID          :string(3)       not null
#  FCCURNAME        :string(35)      not null
#  FCDATEFOR        :string(10)      not null
#  FCDATEMAR        :string(1)       not null
#  FCDECCURR        :string(35)      not null
#  FCDECSYM         :string(6)       not null
#  FCDSEP           :string(1)       not null
#  FCFAMOUNT        :string(20)      not null
#  FCFCOSTPR        :string(20)      not null
#  FCFNUMBER        :string(20)      not null
#  FCFORDER         :string(20)      not null
#  FCFPHONE         :string(20)      not null
#  FCFSTATE         :string(20)      not null
#  FCFTOTAMT        :string(25)      not null
#  FCFTOTNUM        :string(25)      not null
#  FCFZIP           :string(20)      not null
#  FCLANG           :string(8)       not null
#  FCSETCENT        :string(3)       not null
#  FCSSN            :string(15)      not null
#  FCSYMBOL         :string(6)       not null
#  FCTSEP           :string(1)       not null
#  FLEMU            :boolean         not null
#  FNDEFAULT        :integer(4)      not null
#  FNNEGAMT         :integer(4)      not null
#  FNNEGNUM         :integer(4)      not null
#  FNNUMDEC         :integer(4)      not null
#  FNNUMUNITDEC     :integer(4)      not null
#  FNSYMBOL         :integer(4)      not null
#  identity_column  :integer(4)      not null
#  timestamp_column :binary
#

class M2m::Currency < M2m::Base
  set_table_name 'utcurr'
  
  def country_name
    self.FCCOUNTRY.strip
  end
end
