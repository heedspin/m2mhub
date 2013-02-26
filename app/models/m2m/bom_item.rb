# == Schema Information
#
# Table name: inboms
#
#  fcomponent       :string(25)       default(""), not null
#  fcomprev         :string(3)        default(""), not null
#  fitem            :string(6)        default(""), not null
#  fparent          :string(25)       default(""), not null
#  fparentrev       :string(3)        default(""), not null
#  fend_ef_dt       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmemoexist       :string(1)        default(""), not null
#  fqty             :decimal(15, 5)   default(0.0), not null
#  freqd            :string(1)        default(""), not null
#  fst_ef_dt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flextend         :boolean          default(FALSE), not null
#  fltooling        :boolean          default(FALSE), not null
#  fnoperno         :integer          default(0), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fbommemo         :text             default(""), not null
#  cfacilityid      :string(20)       default(""), not null
#  pfacilityid      :string(20)       default(""), not null
#  fcompudrev       :string(3)        default(""), not null
#  fcparudrev       :string(3)        default(""), not null
#  fndbrmod         :integer          default(0), not null
#  flFSSvc          :boolean          default(FALSE), not null
#  fOrigQty         :decimal(15, 5)   default(0.0), not null
#  fcSource         :string(10)       default(""), not null
#

class M2m::BomItem < M2m::Base
  set_table_name 'inboms'
  # set_primary_keys 'fcomponent', 'fcomprev'
  belongs_to_item :fcomponent, :fcomprev
  belongs_to_item :fparent, :fparentrev, :parent

  alias_attribute :quantity, :fqty

  scope :with_parent_item, lambda { |item|
    {
      :conditions => { :fparent => item.part_number, :fparentrev => item.revision }
    }
  }
  scope :with_parent, lambda { |part_number, revision|
    {
      :conditions => { :fparent => part_number, :fparentrev => revision }
    }
  }
  scope :with_child_item, lambda { |item|
    {
      :conditions => { :fcomponent => item.part_number, :fcomprev => item.revision }
    }
  }
  scope :with_parent_part_numbers, lambda { |part_numbers|
    {
      :conditions => ['inboms.fparent in (?)', part_numbers]
    }
  }
  # scope :current, {
  #   :joins => 'invcur on fcpartno = inboms.'
  # }
  scope :just_item_columns, :select => [:fcomponent, :fcomprev, :fparent, :fparentrev]
  scope :by_parent_part_rev, :order => [ :fparent, :fparentrev ]
  scope :by_child_part_rev, :order => [ :fcomponent, :fcomprev ]
  
  def for_parent?(thing)
    (self.parent_part_number == thing.part_number) && (self.parent_revision == thing.revision)
  end
end
