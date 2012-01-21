class M2m::InvoiceItem < M2m::Base
  set_table_name 'aritem'
  
  alias_attribute :rma_key, :fcrmakey

  def part_number
    @part_number ||= self.fpartno.strip
  end
  
  def revision
    @revision ||= self.frev.strip
  end
  
  def rma_number
    M2m::InvoiceItem.rma_number(self.rma_key)
  end
  def self.rma_number(rma_key)
    return nil unless rma_key.present?
    rma_key[0..14].to_i
  end
  def rma_item_number
    M2m::InvoiceItem.rma_item_number(self.rma_key)
  end
  def self.rma_item_number(rma_key)
    return nil unless rma_key.present?
    rma_key[15..-1].to_i
  end
end

# == Schema Information
#
# Table name: aritem
#
#  fbkordqty        :decimal(15, 5)  default(0.0), not null
#  fcinvoice        :string(20)      default(""), not null
#  fcost            :decimal(, )     default(0.0), not null
#  fctype           :string(1)       default(""), not null
#  fcustno          :string(6)       default(""), not null
#  fctaxcode        :string(10)      default(""), not null
#  fcuserline       :string(10)      default(""), not null
#  fdiscamt         :decimal(, )     default(0.0), not null
#  fdisrate         :decimal(7, 2)   default(0.0), not null
#  fincacc          :string(25)      default(""), not null
#  fitem            :string(6)       default(""), not null
#  flcomm           :boolean         default(FALSE), not null
#  flistaxabl       :boolean         default(FALSE), not null
#  fmeasure         :string(3)       default(""), not null
#  fordqty          :decimal(15, 5)  default(0.0), not null
#  fpartno          :string(25)      default(""), not null
#  frev             :string(3)       default(""), not null
#  fprice           :decimal(17, 5)  default(0.0), not null
#  fprodcl          :string(2)       default(""), not null
#  frecvkey         :string(9)       default(""), not null
#  fsalesacc        :string(25)      default(""), not null
#  fshipkey         :string(12)      default(""), not null
#  fshipqty         :decimal(15, 5)  default(0.0), not null
#  fsokey           :string(12)      default(""), not null
#  fsoldby          :string(3)       default(""), not null
#  ftotprice        :decimal(, )     default(0.0), not null
#  fdisceuramt      :decimal(, )     default(0.0), not null
#  fdisctxnamt      :decimal(, )     default(0.0), not null
#  feuroprice       :decimal(17, 5)  default(0.0), not null
#  ftoteurprice     :decimal(, )     default(0.0), not null
#  ftottxnprice     :decimal(, )     default(0.0), not null
#  ftxnprice        :decimal(17, 5)  default(0.0), not null
#  fljrdif          :boolean         default(FALSE), not null
#  fncompct         :decimal(8, 3)   default(0.0), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fmdescript       :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  fpbitem          :string(3)       default(""), not null
#  fpbfinal         :boolean         default(FALSE), not null
#  fcudrev          :string(3)       default(""), not null
#  ContractNu       :string(10)      default(""), not null
#  fnRestock        :decimal(, )     default(0.0), not null
#  fnMiscamt        :decimal(, )     default(0.0), not null
#  fcrmakey         :string(28)      default(""), not null
#

