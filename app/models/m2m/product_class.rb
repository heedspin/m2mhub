# == Schema Information
#
# Table name: inprod
#
#  fpc_number       :string(2)       default(""), not null
#  fcinvadj         :string(25)      default(""), not null
#  fcogslab         :string(25)      default(""), not null
#  fcogsmatl        :string(25)      default(""), not null
#  fcogsothr        :string(25)      default(""), not null
#  fcogsovhd        :string(25)      default(""), not null
#  finvacc          :string(25)      default(""), not null
#  flabacc          :string(25)      default(""), not null
#  flabrvarac       :string(25)      default(""), not null
#  fmatlacc         :string(25)      default(""), not null
#  fmatlvarac       :string(25)      default(""), not null
#  fothracc         :string(25)      default(""), not null
#  fothrvarac       :string(25)      default(""), not null
#  fovhdacc         :string(25)      default(""), not null
#  fovhdvarac       :string(25)      default(""), not null
#  fpc_desc         :string(55)      default(""), not null
#  fpc_name         :string(12)      default(""), not null
#  fpurcvarac       :string(25)      default(""), not null
#  frevalacc        :string(25)      default(""), not null
#  frevenue         :string(25)      default(""), not null
#  fschecode        :string(6)       default(""), not null
#  fschedtype       :string(1)       default(""), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fInvTrans        :string(25)      default(""), not null
#  fac              :string(20)      default(""), not null
#  fintracc         :string(25)      default(""), not null
#  fcogscomms       :string(25)      default(""), not null
#  fsalesret        :string(25)      default(""), not null
#

class M2m::ProductClass < M2m::Base
  set_table_name 'inprod'
  alias_attribute :name, :fpc_name
  alias_attribute :number, :fpc_number
  
  scope :with_name, lambda { |txt|
    {
      :conditions => { :fpc_name => txt.upcase }
    }
  }
end
