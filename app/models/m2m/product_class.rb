# == Schema Information
#
# Table name: inprod
#
#  fpc_number       :string(2)        default(""), not null
#  fcinvadj         :string(25)       default(""), not null
#  fcogslab         :string(25)       default(""), not null
#  fcogsmatl        :string(25)       default(""), not null
#  fcogsothr        :string(25)       default(""), not null
#  fcogsovhd        :string(25)       default(""), not null
#  finvacc          :string(25)       default(""), not null
#  flabacc          :string(25)       default(""), not null
#  flabrvarac       :string(25)       default(""), not null
#  fmatlacc         :string(25)       default(""), not null
#  fmatlvarac       :string(25)       default(""), not null
#  fothracc         :string(25)       default(""), not null
#  fothrvarac       :string(25)       default(""), not null
#  fovhdacc         :string(25)       default(""), not null
#  fovhdvarac       :string(25)       default(""), not null
#  fpc_desc         :string(55)       default(""), not null
#  fpc_name         :string(12)       default(""), not null
#  fpurcvarac       :string(25)       default(""), not null
#  frevalacc        :string(25)       default(""), not null
#  frevenue         :string(25)       default(""), not null
#  fschecode        :string(6)        default(""), not null
#  fschedtype       :string(1)        default(""), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fInvTrans        :string(25)       default(""), not null
#  fac              :string(20)       default(""), not null
#  fintracc         :string(25)       default(""), not null
#  fcogscomms       :string(25)       default(""), not null
#  fsalesret        :string(25)       default(""), not null
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
