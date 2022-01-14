# == Schema Information
#
# Table name: jodbom
#
#  fitem            :char(6)          default("      "), not null
#  fbompart         :char(25)         default("                         "), not null
#  fbomrev          :char(3)          default("   "), not null
#  fbomdesc         :varchar_max(2147 default(""), not null
#  fparent          :char(25)         default("                         "), not null
#  fparentrev       :char(3)          default("   "), not null
#  factqty          :decimal(15, 5)   default(0.0), not null
#  fbomlcost        :decimal(14, 5)   default(0.0), not null
#  fbommeas         :char(3)          default("   "), not null
#  fbomocost        :decimal(14, 5)   default(0.0), not null
#  fbomrec          :integer          default(0), not null
#  fbomsource       :char(1)          default(" "), not null
#  fbook            :decimal(15, 5)   default(0.0), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  finumber         :char(3)          default("   "), not null
#  fjobno           :varchar(20)      default(""), not null
#  flabcost         :decimal(17, 5)   default(0.0), not null
#  flabsetcos       :decimal(17, 5)   default(0.0), not null
#  flastoper        :integer          default(0), not null
#  flextend         :boolean          default(FALSE), not null
#  fltooling        :boolean          default(FALSE), not null
#  fmatlcost        :decimal(17, 5)   default(0.0), not null
#  fneed_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnumopers        :integer          default(0), not null
#  fbominum         :char(4)          default("    "), not null
#  fothrcost        :decimal(17, 5)   default(0.0), not null
#  fovrhdcost       :decimal(17, 5)   default(0.0), not null
#  fovrhdsetc       :decimal(17, 5)   default(0.0), not null
#  fpono            :varchar(10)      default(""), not null
#  fpoqty           :decimal(15, 5)   default(0.0), not null
#  fqtytopurc       :decimal(15, 5)   default(0.0), not null
#  fqty_iss         :decimal(15, 5)   default(0.0), not null
#  fresponse        :char(1)          default(" "), not null
#  fsubcost         :decimal(17, 5)   default(0.0), not null
#  fsub_job         :varchar(20)      default(""), not null
#  fsub_rel         :boolean          default(FALSE), not null
#  ftotptime        :decimal(9, 2)    default(0.0), not null
#  ftotqty          :decimal(20, 10)  default(0.0), not null
#  ftotstime        :decimal(9, 2)    default(0.0), not null
#  ftransinv        :decimal(15, 5)   default(0.0), not null
#  fvendno          :char(6)          default("      "), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :char(1)          default(" "), not null
#  fnretpoqty       :decimal(15, 5)   default(0.0), not null
#  fnoperno         :integer          default(0), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fstdmemo         :varchar_max(2147 default(""), not null
#  fpneed_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  Cfac             :char(20)         default("                    "), not null
#  fcbomudrev       :char(3)          default("   "), not null
#  fcparudrev       :char(3)          default("   "), not null
#  fiissdpcs        :integer          default(0), not null
#  fipopieces       :integer          default(0), not null
#  fndbrmod         :integer          default(0), not null
#  fnqtylnd         :decimal(17, 5)   default(0.0), not null
#  Pfac             :char(20)         default("                    "), not null
#  fOrigQty         :decimal(15, 5)   default(0.0), not null
#  SchedDate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnISOQty         :decimal(15, 5)   default(0.0), not null
#  fcSource         :varchar(10)      default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#  FREQD            :char(1)          default("0"), not null
#
class M2m::JobDetailBom < M2m::Base
  self.table_name = 'jodbom'

  alias_attribute :job_number, :fjobno
  belongs_to_item :fbompart, :fbomrev

  def issued_material_cost
  	self.fmatlcost * self.fqty_iss
  end

  def self.attach(map)
    self.where(:fjobno => map.keys).each { |d| map[d.job_number].add_cached_detail_bom(d) }
  end

end
