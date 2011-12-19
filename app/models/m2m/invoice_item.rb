class M2m::InvoiceItem < M2m::Base
  set_table_name 'aritem'

  def part_number
    @part_number ||= self.fpartno.strip
  end
  
  def revision
    @revision ||= self.frev.strip
  end
end
# == Schema Information
#
# Table name: aritem
#
#  fbkordqty        :decimal(15, 5)  not null
#  fcinvoice        :string(20)      not null
#  fcost            :decimal(, )     not null
#  fctype           :string(1)       not null
#  fcustno          :string(6)       not null
#  fctaxcode        :string(10)      not null
#  fcuserline       :string(10)      not null
#  fdiscamt         :decimal(, )     not null
#  fdisrate         :decimal(7, 2)   not null
#  fincacc          :string(25)      not null
#  fitem            :string(6)       not null
#  flcomm           :boolean         not null
#  flistaxabl       :boolean         not null
#  fmeasure         :string(3)       not null
#  fordqty          :decimal(15, 5)  not null
#  fpartno          :string(25)      not null
#  frev             :string(3)       not null
#  fprice           :decimal(17, 5)  not null
#  fprodcl          :string(2)       not null
#  frecvkey         :string(9)       not null
#  fsalesacc        :string(25)      not null
#  fshipkey         :string(12)      not null
#  fshipqty         :decimal(15, 5)  not null
#  fsokey           :string(12)      not null
#  fsoldby          :string(3)       not null
#  ftotprice        :decimal(, )     not null
#  fdisceuramt      :decimal(, )     not null
#  fdisctxnamt      :decimal(, )     not null
#  feuroprice       :decimal(17, 5)  not null
#  ftoteurprice     :decimal(, )     not null
#  ftottxnprice     :decimal(, )     not null
#  ftxnprice        :decimal(17, 5)  not null
#  fljrdif          :boolean         not null
#  fncompct         :decimal(8, 3)   not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fmdescript       :text            default(" "), not null
#  fac              :string(20)      not null
#  fpbitem          :string(3)       default(""), not null
#  fpbfinal         :boolean         default(FALSE), not null
#  fcudrev          :string(3)       default(" "), not null
#

