# == Schema Information
#
# Table name: glmast
#
#  fcacctnum        :char(25)         default("                         "), not null
#  fcclass          :char(1)          default(" "), not null
#  fccode           :char(1)          default(" "), not null
#  fcdescr          :varchar(40)      default(""), not null
#  fcparentid       :char(25)         default("                         "), not null
#  fctype           :char(3)          default("   "), not null
#  flfunds          :boolean          default(FALSE), not null
#  flconsol         :boolean          default(FALSE), not null
#  flinactive       :boolean          default(FALSE), not null
#  fnorder          :integer          default(0), not null
#  flrevlcurr       :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmnote           :varchar_max(2147 default(""), not null
#  fcactcat         :char(1)          default(" "), not null
#  flcash           :boolean          default(FALSE), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::GlAccount < M2m::Base
  self.table_name = 'glmast'
  belongs_to :gl_category, :class_name => 'M2m::GlCategory', :foreign_key => 'fccode', :primary_key => 'fccode'
  alias_attribute :category_code, :fccode
  alias_attribute :account_number, :fcacctnum
  alias_attribute :parent_account_number, :fcparentid
  alias_attribute :class_key, :fcclass
  alias_attribute :description, :fcdescr
  scope :account_number, -> (n) {
    where :fcacctnum => n
  }
  scope :parent_account_number, -> (n) {
    where :fcparentid => n
  }
  scope :revenue_account, -> { where(:fccode => 'R') }
  def description
    self.fcdescr.strip.titleize
  end
  def credit?
    self.class_key == 'C'
  end
  def debit?
    self.class_key == 'D'
  end
  def parent
    @parent ||= M2m::GlAccount.account_number(self.parent_account_number).first
  end
  def children
    @children ||= M2m::GlAccount.parent_account_number(self.account_number).all
  end
  def value_multiplier
    case self.category_code
    when 'R'
      -1
    else
      1
    end
  end
end
