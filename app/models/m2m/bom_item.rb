class M2m::BomItem < M2m::Base
  set_table_name 'inboms'
  # set_primary_key 'fpartno'
  set_primary_keys 'fcomponent', 'fcomprev'
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fcomponent, :fcomprev]
  belongs_to :parent_item, :class_name => 'M2m::Item', :foreign_key => [:fparent, :fparentrev]
  
  named_scope :for_parent_item, lambda { |part_number, revision|
    {
      :joins => :parent_item,
      :conditions => { :inmast => { :fpartno => part_number, :frev => revision } }      
    }
  }
  
  alias_attribute :part_number, :fcomponent
  alias_attribute :revision, :fcomprev
  alias_attribute :parent_part_number, :fparent
  alias_attribute :parent_revision, :fparentrev
  alias_attribute :quantity, :fqty
end
# == Schema Information
#
# Table name: inboms
#
#  fcomponent       :string(25)      not null
#  fcomprev         :string(3)       not null
#  fitem            :string(6)       not null
#  fparent          :string(25)      not null
#  fparentrev       :string(3)       not null
#  fend_ef_dt       :datetime        not null
#  fmemoexist       :string(1)       not null
#  fqty             :decimal(15, 5)  not null
#  freqd            :string(1)       not null
#  fst_ef_dt        :datetime        not null
#  flextend         :boolean         not null
#  fltooling        :boolean         not null
#  fnoperno         :integer         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fbommemo         :text            default(" "), not null
#  cfacilityid      :string(20)      not null
#  pfacilityid      :string(20)      not null
#  fcompudrev       :string(3)       default(" "), not null
#  fcparudrev       :string(3)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#  fOrigQty         :decimal(15, 5)  not null
#  flFSSvc          :boolean         not null
#

