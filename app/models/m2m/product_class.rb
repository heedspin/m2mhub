# == Schema Information
#
# Table name: inprod
#
#  fpc_number       :varchar(4)       default(""), not null
#  fcinvadj         :char(25)         default("                         "), not null
#  fcogslab         :char(25)         default("                         "), not null
#  fcogsmatl        :char(25)         default("                         "), not null
#  fcogsothr        :char(25)         default("                         "), not null
#  fcogsovhd        :char(25)         default("                         "), not null
#  finvacc          :char(25)         default("                         "), not null
#  flabacc          :char(25)         default("                         "), not null
#  flabrvarac       :char(25)         default("                         "), not null
#  fmatlacc         :char(25)         default("                         "), not null
#  fmatlvarac       :char(25)         default("                         "), not null
#  fothracc         :char(25)         default("                         "), not null
#  fothrvarac       :char(25)         default("                         "), not null
#  fovhdacc         :char(25)         default("                         "), not null
#  fovhdvarac       :char(25)         default("                         "), not null
#  fpc_desc         :varchar(55)      default(""), not null
#  fpc_name         :char(12)         default("            "), not null
#  fpurcvarac       :char(25)         default("                         "), not null
#  frevalacc        :char(25)         default("                         "), not null
#  frevenue         :char(25)         default("                         "), not null
#  fschecode        :char(6)          default("      "), not null
#  fschedtype       :char(1)          default(" "), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fInvTrans        :char(25)         default("                         "), not null
#  fac              :char(20)         default("                    "), not null
#  fintracc         :char(25)         default("                         "), not null
#  fcogscomms       :char(25)         default("                         "), not null
#  fsalesret        :varchar(25)      default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::ProductClass < M2m::Base
  self.table_name = 'inprod'
  alias_attribute :name, :fpc_name
  alias_attribute :number, :fpc_number
  
  scope :with_name, -> (txt) {
    where :fpc_name => txt.upcase
  }
  def self.product_class_key(fpc_number)
    where(:fpc_number => fpc_number)
  end

  #     ["ACCESSORIES ",
   # "DO NOT USE  ",
   # "RAW MATERIAL",
   # "MODULES     ",
   # "OLEDS       ",
   # "TFTS        ",
   # "NRE/TOOLING ",
   # "GLASS       ",
   # "SHIPPING    ",
   # "TAX         "

   def inventory_item?
    !['NRE/TOOLING', 'TAX', 'SHIPPING'].include?(self.fpc_name.strip)
   end

  def ns_name
    stripped_name = self.name.strip
    case stripped_name
    when 'RAW MATERIAL'
      'Raw Materials'
    when 'NRE/TOOLING'
      'NRE/Tooling'
    when 'TAX'
      'Tariffs'
    when 'OLEDS'
      'OLEDS'
    when 'TFTS'
      'TFTS'
    else
      stripped_name.titleize
    end
  end

  def self.all_inventory_item_class_keys
    @@all_inventory_class_keys ||= self.all.select { |pc| pc.inventory_item? }.map(&:fpc_number)
  end
  def self.all_non_inventory_item_class_keys
    @@all_non_inventory_class_keys ||= self.all.select { |pc| !pc.inventory_item? }.map(&:fpc_number)
  end
end
