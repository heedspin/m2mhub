class M2m::BomItem < M2m::Base
  set_table_name 'inboms'
  # set_primary_keys 'fcomponent', 'fcomprev'
  belongs_to_item :fcomponent, :fcomprev
  belongs_to_item :fparent, :fparentrev, :parent

  alias_attribute :quantity, :fqty
  
  scope :for_parent_item, lambda { |part_number, revision|
    {
      :joins => :parent_item,
      :conditions => { :inmastx => { :fpartno => part_number, :frev => revision } }      
    }
  }
  scope :with_child_item, lambda { |item|
    {
      :conditions => { :fcomponent => item.part_number, :fcomprev => item.revision }
    }
  }
  
  scope :just_item_columns, :select => [:fcomponent, :fcomprev, :fparent, :fparentrev]
end

# == Schema Information
#
# Table name: inboms
#
#  fcomponent       :string(25)      default(""), not null
#  fcomprev         :string(3)       default(""), not null
#  fitem            :string(6)       default(""), not null
#  fparent          :string(25)      default(""), not null
#  fparentrev       :string(3)       default(""), not null
#  fend_ef_dt       :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmemoexist       :string(1)       default(""), not null
#  fqty             :decimal(15, 5)  default(0.0), not null
#  freqd            :string(1)       default(""), not null
#  fst_ef_dt        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flextend         :boolean         default(FALSE), not null
#  fltooling        :boolean         default(FALSE), not null
#  fnoperno         :integer(4)      default(0), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fbommemo         :text            default(""), not null
#  cfacilityid      :string(20)      default(""), not null
#  pfacilityid      :string(20)      default(""), not null
#  fcompudrev       :string(3)       default(""), not null
#  fcparudrev       :string(3)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#  flFSSvc          :boolean         default(FALSE), not null
#  fOrigQty         :decimal(15, 5)  default(0.0), not null
#  fcSource         :string(10)      default(""), not null
#

