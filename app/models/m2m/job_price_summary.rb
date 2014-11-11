# == Schema Information
#
# Table name: jopest
#
#  fjobno           :string(10)       default(""), not null
#  fbuy_itm         :integer          default(0), not null
#  fcus_itm         :integer          default(0), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  finoper          :integer          default(0), not null
#  finumber         :string(3)        default(""), not null
#  flabcost         :decimal(17, 5)   default(0.0), not null
#  flastoper        :integer          default(0), not null
#  fldhrs           :decimal(14, 5)   default(0.0), not null
#  fmak_itm         :integer          default(0), not null
#  fmatlcost        :decimal(17, 5)   default(0.0), not null
#  fmovehrs         :decimal(8, 2)    default(0.0), not null
#  fno_bom          :boolean          default(FALSE), not null
#  fno_rtg          :boolean          default(FALSE), not null
#  fnumopers        :integer          default(0), not null
#  fothrcost        :decimal(17, 5)   default(0.0), not null
#  fovhdcost        :decimal(17, 5)   default(0.0), not null
#  fovhdsc          :decimal(17, 5)   default(0.0), not null
#  fprodhrs         :decimal(14, 5)   default(0.0), not null
#  fsetupcost       :decimal(17, 5)   default(0.0), not null
#  fsetuphrs        :decimal(7, 2)    default(0.0), not null
#  fstk_itm         :integer          default(0), not null
#  fsubcost         :decimal(17, 5)   default(0.0), not null
#  fsubhrs          :integer          default(0), not null
#  fsuboper         :integer          default(0), not null
#  ftoolcost        :decimal(17, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#

class M2m::JobPriceSummary < M2m::Base
	self.table_name = 'jopest'

	alias_attribute :material_cost, :fmatlcost
	alias_attribute :sub_cost, :fsubcost
	alias_attribute :fixed_cost, :ffixcost
	alias_attribute :other_cost, :fothrcost
	alias_attribute :labor_cost, :flabcost
	alias_attribute :overhead_cost, :fovhdcost
	alias_attribute :overhead_set_cost, :fovhdsc
	alias_attribute :setup_cost, :fsetupcost

	def total_cost
		self.material_cost + self.sub_cost + self.fixed_cost + self.other_cost + self.labor_cost + self.setup_cost + self.overhead_cost + self.overhead_set_cost
	end
end
