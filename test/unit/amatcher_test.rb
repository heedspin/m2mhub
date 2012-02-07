require File.dirname(__FILE__) + '/../test_helper'

require 'amatcher'

class AmatcherTest < ActiveSupport::TestCase
  def test_amatcher
    similar_customers = Amatcher.find_similar( :match => 'sense it', :method => :company_name,
                                               :objects => M2m::Customer.scoped(:select => 'slcdpmx.identity_column, slcdpmx.fcompany'),
                                               :limit => 10, :threshold => 0.4 )
    puts similar_customers.map { |r| r.object.company_name + ' - ' + r.weight.to_s }.join("\n")
  end
end
