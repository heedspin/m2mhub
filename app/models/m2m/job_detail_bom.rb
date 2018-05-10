# == Schema Information

#
# Table name: jodbom
#
#  fitem            :string(6)        default(""), not null
#  fbompart         :string(25)       default(""), not null
#  fbomrev          :string(3)        default(""), not null
#  fbomdesc         :string(65)       default(""), not null
#  fparent          :string(25)       default(""), not null
#  fparentrev       :string(3)        default(""), not null
#  factqty          :decimal(15, 5)   default(0.0), not null
#  fbomlcost        :decimal(14, 5)   default(0.0), not null
#  fbommeas         :string(3)        default(""), not null
#  fbomocost        :decimal(14, 5)   default(0.0), not null
#  fbomrec          :integer          default(0), not null
#  fbomsource       :string(1)        default(""), not null
#  fbook            :decimal(15, 5)   default(0.0), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  finumber         :string(3)        default(""), not null
#  fjobno           :string(10)       default(""), not null
#  flabcost         :decimal(17, 5)   default(0.0), not null
#  flabsetcos       :decimal(17, 5)   default(0.0), not null
#  flastoper        :integer          default(0), not null
#  flextend         :boolean          default(FALSE), not null
#  fltooling        :boolean          default(FALSE), not null
#  fmatlcost        :decimal(17, 5)   default(0.0), not null
#  fneed_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnumopers        :integer          default(0), not null
#  fbominum         :string(4)        default(""), not null
#  fothrcost        :decimal(17, 5)   default(0.0), not null
#  fovrhdcost       :decimal(17, 5)   default(0.0), not null
#  fovrhdsetc       :decimal(17, 5)   default(0.0), not null
#  fpono            :string(6)        default(""), not null
#  fpoqty           :decimal(15, 5)   default(0.0), not null
#  fqtytopurc       :decimal(15, 5)   default(0.0), not null
#  fqty_iss         :decimal(15, 5)   default(0.0), not null
#  fresponse        :string(1)        default(""), not null
#  fsubcost         :decimal(17, 5)   default(0.0), not null
#  fsub_job         :string(10)       default(""), not null
#  fsub_rel         :boolean          default(FALSE), not null
#  ftotptime        :decimal(9, 2)    default(0.0), not null
#  ftotqty          :decimal(20, 10)  default(0.0), not null
#  ftotstime        :decimal(9, 2)    default(0.0), not null
#  ftransinv        :decimal(15, 5)   default(0.0), not null
#  fvendno          :string(6)        default(""), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :string(1)        default(""), not null
#  fnretpoqty       :decimal(15, 5)   default(0.0), not null
#  fnoperno         :integer          default(0), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fstdmemo         :text             default(""), not null
#  fpneed_dt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  Cfac             :string(20)       default(""), not null
#  fcbomudrev       :string(3)        default(""), not null
#  fcparudrev       :string(3)        default(""), not null
#  fiissdpcs        :integer          default(0), not null
#  fipopieces       :integer          default(0), not null
#  fndbrmod         :integer          default(0), not null
#  fnqtylnd         :decimal(17, 5)   default(0.0), not null
#  Pfac             :string(20)       default(""), not null
#  fOrigQty         :decimal(15, 5)   default(0.0), not null
#  SchedDate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnISOQty         :decimal(15, 5)   default(0.0), not null
#  fcSource         :string(10)       default(""), not null
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
