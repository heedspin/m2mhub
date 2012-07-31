require 'singleton'

# Put this in your development.rb:
#
# require 'obfuscator/obfuscator'
# config.to_prepare do
#   Obfuscator.configure
# end

# Picks random names and addresses for you.
class Obfuscator
  include Singleton

  def initialize
    @female_names = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/female.txt'), 'r') do |input|
      while line = input.gets
        @female_names.push line.titleize.strip
      end
    end
    @male_names = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/male.txt'), 'r') do |input|
      while line = input.gets
        @male_names.push line.titleize.strip
      end
    end
    @last_names = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/last.txt'), 'r') do |input|
      while line = input.gets
        @last_names.push line.titleize.strip
      end
    end
    @street_names = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/streets.txt'), 'r') do |input|
      while line = input.gets
        @street_names.push line.titleize.strip
      end
    end
    @company_names = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/company_names.txt'), 'r') do |input|
      while line = input.gets
        @company_names.push line.titleize.strip
      end
    end
    @adjectives = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/adjectives.txt'), 'r') do |input|
      while line = input.gets
        @adjectives.push line.titleize.strip
      end
    end
    @nouns = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/nouns.txt'), 'r') do |input|
      while line = input.gets
        @nouns.push line.titleize.strip
      end
    end
    @verbs = []
    File.open(File.join(M2mhub::Engine.root, 'lib/obfuscator/verbs.txt'), 'r') do |input|
      while line = input.gets
        @verbs.push line.titleize.strip
      end
    end
  end

  def female_name
    @female_names[rand(@female_names.size)]
  end

  def male_name
    @male_names[rand(@male_names.size)]
  end

  def first_name
    if rand(2) == 0
      male_name
    else
      female_name
    end
  end

  def last_name
    @last_names[rand(@last_names.size)]
  end

  def street_name
    @street_names[rand(@street_names.size)]
  end

  def company_name(seed=nil)
    choose(@company_names, seed)
  end

  def part_number(seed=nil)
    if seed.nil?
      'PN-' + (rand(9000) + 1000).to_s
    else
      code = 0
      seed.each_byte{|b| code += b}
      "PN-%04d" % code
    end
  end

  def customer_part_number(seed=nil)
    code = 0
    seed.each_byte{|b| code += b}
    "CN-%06d" % code
  end

  def choose(choices, seed)
    index = if seed.nil?
      rand(choices.size)
    else
      code = 0
      seed.strip.downcase.each_byte{|b| code += b}
      code % choices.size
    end
    @company_names[index]
  end

  def email
    'nobody@nowhere.dot'
  end

  def street_address
    result = ''
    (rand(4)+1).times { result << rand(10).to_s }
    result << ' '
    result << street_name
    result
  end

  def phone_number
    '555' + '-' + rand(10).to_s + rand(10).to_s + rand(10).to_s + '-' + rand(10).to_s + rand(10).to_s + rand(10).to_s + rand(10).to_s
  end

  def noun
    @nouns[rand(@nouns.size)]
  end

  def adjective
    @adjectives[rand(@adjectives.size)]
  end

  def verb
    @verbs[rand(@verbs.size)]
  end

  def part_description
    self.adjective + ' ' + self.noun
  end

  def lipsum_sentence(real_words)
    return nil unless real_words.present?
    @lipsum_words ||= %w(aenean aliquam donec duis etiam fusce integer lorem maecenas mauris nam nulla nullam nunc pellentesque phasellus proin quisque sed suspendisse a ac accumsan adipiscing aliquam aliquet amet ante at auctor augue bibendum blandit condimentum consectetur consequat convallis cursus dapibus diam dolor dui eget eleifend elit enim erat eros et eu euismod felis feugiat hendrerit iaculis id in ipsum justo lacinia lacus laoreet lectus leo libero ligula lobortis lorem luctus magna malesuada massa mauris metus molestie mollis neque nibh nisi nisl non nulla nunc odio orci ornare placerat porta porttitor potenti pretium pulvinar purus quam quis rhoncus risus sagittis sapien scelerisque sed sem sit sodales sollicitudin suscipit tellus tempor tempus tincidunt tortor tristique ullamcorper urna ut vehicula vel venenatis vestibulum vitae viverra volutpat vulputate)
    result = [ @lipsum_words[rand(@lipsum_words.size)].capitalize ]
    (rand(5)+5).times { result.push @lipsum_words[rand(@lipsum_words.size)] }
    result.join(' ') + '.'
  end

  def some_digits(seed=nil)
    if seed.nil?
      '%07d' % rand(9999999)
    else
      code = 0
      seed.strip.downcase.each_byte{|b| code += b}
      '%07d' % code
    end
  end

  def smaller_dollars(seed=nil)
    rand(1000).to_f / 100 + 1 * (seed < 0 ? -1 : 1)
  end

  def small_dollars(seed=nil)
    rand(10000).to_f / 100 + 10 * (seed < 0 ? -1 : 1)
  end

  def dollars(seed=nil)
    rand(1000000).to_f / 100 * (seed < 0 ? -1 : 1)
  end

  def medium_dollars(seed=nil)
    rand(5000000).to_f / 100 + 10000 * (seed < 0 ? -1 : 1)
  end

  def large_dollars(seed=nil)
    rand(100000000).to_f / 100 + 100000 * (seed < 0 ? -1 : 1)
  end

  def larger_dollars(seed=nil)
    rand(1000000000).to_f / 100 + 1000000 * (seed < 0 ? -1 : 1)
  end

  def hundreds
    rand(999) + 100
  end

  def thousands
    rand(9999) + 1000
  end

  def shipping_company
    @shipping_companies ||= ['Seabourn', 'Clipper', 'Oglebay', 'Sealift', 'Halliburton', 'Conoco', 'Tidewater', 'McDermott']
    @shipping_companies[rand(@shipping_companies.size)]
  end

  def tracking_code
    (rand(26) + 65).chr + ('%06d' % rand(1000000))
  end

  def self.obfuscate_attributes(args)
    assignments = []
    args.each do |obj_key, obfuscate_key|
      value = if Obfuscator.instance.method(obfuscate_key).arity == 0
        "Obfuscator.instance.#{obfuscate_key}"
      else
        "Obfuscator.instance.#{obfuscate_key}(obj.#{obj_key})"
      end
      assignments.push "obj.#{obj_key} = #{value} rescue ActiveModel::MissingAttributeError"
    end
    ruby_code = <<-RUBY
    after_find do |obj|
      #{assignments.join("\n\t")}
    end
    RUBY
    mod = Module.new
    mod.class_eval <<-RUBY
    def self.included(base)
      base.class_eval <<-TEXT
      #{ruby_code}
      TEXT
    end
    RUBY
    mod
  end

  def self.obfuscate_methods(args)
    methods = []
    args.each do |obj_key, obfuscate_key|
      value = if Obfuscator.instance.method(obfuscate_key).arity == 0
        methods.push <<-RUBY
        def #{obj_key}
          Obfuscator.instance.#{obfuscate_key}
        end
        RUBY
      else
        methods.push <<-RUBY
        unless defined?(OLD_#{obj_key})
          OLD_#{obj_key} = instance_method('#{obj_key}')
          def #{obj_key}
            seed = OLD_#{obj_key}.bind(self).call
            Obfuscator.instance.#{obfuscate_key}(seed)
          end
        end
        RUBY
      end
    end
    mod = Module.new
    mod.class_eval <<-RUBY
    def self.included(base)
      base.class_eval <<-TEXT
      #{methods.join("\n")}
      TEXT
    end
    RUBY
    mod
  end

  def self.configure
    M2m::Rma.send :include, obfuscate_attributes( :fcompany => :company_name )
    M2m::RmaItem.send :include, obfuscate_attributes( :freason => :lipsum_sentence )
    M2m::RmaItem.send :include, obfuscate_methods( :invoice_amount => :dollars )
    Quality::CreditMemoReport::Month.send :include, obfuscate_methods( :invoice_total => :large_dollars )
    Quality::CreditMemoReport::VendorReport.send :include, obfuscate_methods( :invoice_total => :larger_dollars )
    M2m::Vendor.send :include, obfuscate_attributes( :name => :company_name )
    Quality::CustomerOtdReport::Month.send :include, obfuscate_methods( :num_releases => :thousands )
    M2m::SalesOrder.send :include, obfuscate_attributes( :ship_via => :shipping_company,
                                                         :customer_po => :some_digits )
    M2m::SalesOrderItem.send :include, obfuscate_attributes( :fdesc => :part_description,
                                                             :fcustpart => :customer_part_number )
    M2m::SalesOrderItem.send :include, obfuscate_methods( :total_price => :dollars )
    M2m::SalesOrderRelease.send :include, obfuscate_attributes( :unit_price => :small_dollars )
    M2m::Quote.send :include, obfuscate_attributes( :memo => :lipsum_sentence )
    M2m::QuoteItem.send :include, obfuscate_attributes( :unit_price => :small_dollars,
                                                        :description => :part_description,
                                                        :customer_part_number => :customer_part_number )
    M2m::Shipper.send :include, obfuscate_attributes( :fshipvia => :shipping_company,
                                                      :customer_po => :some_digits,
                                                      :fbl_lading => :tracking_code )
    M2m::Receiver.send :include, obfuscate_attributes( :fpono => :tracking_code )
    M2m::PurchaseOrderItem.send :include, obfuscate_attributes( :fvpartno => :part_number )
    M2m::InventoryVendor.send :include, obfuscate_attributes( :fvpartno => :part_number )
    M2m::Customer.send :include, obfuscate_attributes( :fcompany => :company_name,
                                                       :fcontact => :last_name,
                                                       :fcfname => :first_name,
                                                       :fmnotes => :lipsum_sentence,
                                                       :ffax => :phone_number )
    M2m::Contact.send :include, obfuscate_attributes( :fcontact => :last_name,
                                                      :fcfname => :first_name,
                                                      :PhoneWork => :phone_number,
                                                      :fcemail => :email,
                                                      :fcfax => :phone_number)
    M2m::Item.send :include, obfuscate_attributes( :description => :part_description )
    M2m::Item.send :include, obfuscate_methods( :total_cost => :smaller_dollars )
    M2m::WorkCenter.send :include, obfuscate_attributes( :fcpro_name => :verb )
    M2m::Customer.class_eval <<-RUBY
    def self.customer_name(txt)
      Obfuscator.instance.company_name(txt)
    end
    RUBY
    Sales::SalesReport.send :include, obfuscate_attributes( :invoiced_sales => :large_dollars,
                                                            :net_invoiced_sales => :large_dollars,
                                                            :ytd_invoiced_sales => :larger_dollars )
    Sales::BookingsReport.send :include, obfuscate_attributes( :bookings => :large_dollars,
                                                               :ytd_bookings => :larger_dollars )
    Sales::BacklogReport.send :include, obfuscate_attributes( :total_backlog => :larger_dollars )
    Sales::BacklogReport::SalesReleaseSummary.send :include, obfuscate_methods( :backlog_price => :medium_dollars )
    M2m::GlAccount.send :include, obfuscate_attributes( :description => :part_description )
    M2m::GlTransaction.send :include, obfuscate_attributes( :amount => :dollars )
    M2m::ArDistribution.send :include, obfuscate_attributes( :amount => :dollars )
    Production::InventoryReport.send :include, obfuscate_attributes( :total_on_hand_cost => :larger_dollars,
                                                                     :total_on_order_cost => :larger_dollars,
                                                                     :total_available_cost => :large_dollars,
                                                                     :total_committed_cost => :larger_dollars )
    Production::InventoryReportItem.send :include, obfuscate_attributes( :quantity_on_hand => :thousands,
                                                                         :quantity_committed => :thousands,
                                                                         :quantity_available => :hundreds,
                                                                         :quantity_on_order => :thousands,
                                                                         :cost => :large_dollars )
    Production::InventoryReportCustomer.send :include, obfuscate_attributes( :customer_name => :company_name,
                                                                             :total_on_hand_cost => :dollars,
                                                                             :total_on_order_cost => :dollars,
                                                                             :total_available_cost => :dollars,
                                                                             :total_committed_cost => :dollars )
    movement_methods = {}
    Production::InventoryMovementData::TTYPES.each do |ttype|
      movement_methods[ttype.cmethod] = :hundreds
      movement_methods[ttype.cmethod.to_s + '_cost'] = :hundreds
    end
    Production::InventoryMovementData.send :include, obfuscate_methods(movement_methods)
    M2m::PurchaseQueueSummary.send :include, obfuscate_attributes( :vendor_name1 => :company_name )
    Production::PurchaseQueueNote.send :include, obfuscate_attributes( :comments => :lipsum_sentence )
  end
end
