# == Schema Information
#
# Table name: inboms
#
#  fcomponent       :char(25)         default("                         "), not null
#  fcomprev         :char(3)          default("   "), not null
#  fitem            :char(6)          default("      "), not null
#  fparent          :char(25)         default("                         "), not null
#  fparentrev       :char(3)          default("   "), not null
#  fend_ef_dt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fmemoexist       :char(1)          default(" "), not null
#  fqty             :decimal(15, 5)   default(0.0), not null
#  freqd            :char(1)          default(" "), not null
#  fst_ef_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flextend         :boolean          default(FALSE), not null
#  fltooling        :boolean          default(FALSE), not null
#  fnoperno         :integer          default(0), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fbommemo         :varchar_max(2147 default(""), not null
#  cfacilityid      :char(20)         default("                    "), not null
#  pfacilityid      :char(20)         default("                    "), not null
#  fcompudrev       :char(3)          default("   "), not null
#  fcparudrev       :char(3)          default("   "), not null
#  fndbrmod         :integer          default(0), not null
#  fOrigQty         :decimal(15, 5)   default(0.0), not null
#  flFSSvc          :boolean          default(FALSE), not null
#  fcSource         :varchar(10)      default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::BomItem < M2m::Base
  self.table_name = 'inboms'
  belongs_to_item :fcomponent, :fcomprev
  belongs_to_item :fparent, :fparentrev, :parent

  alias_attribute :quantity, :fqty

  scope :with_parent_item, -> (item) {
    where :fparent => item.part_number, :fparentrev => item.revision
  }
  scope :with_parent, -> (part_number, revision) {
    where :fparent => part_number, :fparentrev => revision
  }
  scope :with_child_item, -> (item) {
    where :fcomponent => item.part_number, :fcomprev => item.revision
  }
  scope :with_parent_part_numbers, -> (part_numbers) {
    where ['inboms.fparent in (?)', part_numbers]
  }
  # scope :current, {
  #   :joins => 'invcur on fcpartno = inboms.'
  # }
  scope :just_item_columns, -> { select(:fcomponent, :fcomprev, :fparent, :fparentrev) }
  scope :by_parent_part_rev, -> { order(:fparent, :fparentrev) }
  scope :by_child_part_rev, -> { order(:fcomponent, :fcomprev) }
  
  def for_parent?(thing)
    (self.parent_part_number == thing.part_number) && (self.parent_revision == thing.revision)
  end
end
