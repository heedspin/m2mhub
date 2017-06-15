# == Schema Information
#
# Table name: sales_quote_items
#
#  id                   :integer          not null, primary key
#  quote_id             :integer
#  position             :integer
#  part_number          :string(255)
#  revision             :string(255)
#  display_id           :integer
#  description          :text
#  customer_part_number :string(255)
#  price_method_id      :integer
#  quantity             :decimal(12, 2)
#  expected_cost        :decimal(14, 2)
#  price                :decimal(14, 2)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'm2mhub_current_user'

class Sales::QuoteItem < M2mhub::Base
  self.table_name = 'sales_quote_items'
  belongs_to :quote, :class_name => 'Sales::Quote'
  has_one :display_log, :class_name => 'Doogle::DisplayLog', :foreign_key => 'object_id', :primary_key => 'quote_id', :conditions => { :log_type_id => Doogle::LogType.quote.id }

  scope :by_position, -> { order(:position, :id) }

  def margin
    if @margin.nil?
      return nil unless (self.price.present? and (self.price > 0)) and (self.expected_cost.present?)
      @margin = (self.price - self.expected_cost) / self.price
    end
    @margin
  end

  def expected_cost=(val)
    val = val.gsub('$','') if val.is_a?(String)
    super(val)
  end

  attr_accessor :price_set_by_margin
  def price=(val)
    @price_set_by_margin = false
    if val.is_a?(String)
      if val.include?('%') and self.expected_cost.present?
        val = val.gsub('%', '').to_f
        val = (self.expected_cost.to_f / ((100 - val) / 100)).round(2)
        @price_set_by_margin = true
      else
        val = val.gsub('$','')
      end
    end
    super(val)
  end

  def total_price
    (self.quantity || 0) * (self.price || 0)
  end


  after_create :create_display_log
  def create_display_log
    if display = Doogle::Display.find_by_model_number(self.part_number)
      unless display.logs.log_type(Doogle::LogType.quote).with_object_id(self.quote_id).count > 0
        display.logs.create( :log_type => Doogle::LogType.quote,
                             :object_id => self.quote_id,
                             :user_id => M2mhubCurrentUser.user.try(:id),
                             :summary => 'Quote',
                             :event_time => self.created_at )
      end
    end
  end

  before_update :update_display_log
  def update_display_log
    if self.part_number_changed?
      self.destroy_all_display_logs(self.part_number_was)
      self.create_display_log
    end
  end

  before_destroy :destroy_display_log
  def destroy_display_log
    destroy_all_display_logs(self.part_number)
  end

  def destroy_all_display_logs(part_number)
    if display = Doogle::Display.find_by_model_number(self.part_number)
      if self.quote.items.where(['sales_quote_items.part_number = ? and sales_quote_items.id != ?', part_number, self.id]).count == 0
        Doogle::DisplayLog.log_type(Doogle::LogType.quote).with_object_id(self.quote_id).for_display(display).destroy_all
      end
    end
  end
end
