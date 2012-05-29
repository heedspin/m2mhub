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
    code = 0
    seed.each_byte{|b| code += b}
    "PN-%04d" % code
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

  def lipsum_sentence
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

  def shipping_company
    @shipping_companies ||= ['Seabourn', 'Clipper', 'Oglebay', 'Sealift', 'Halliburton', 'Conoco', 'Tidewater', 'McDermott']
    @shipping_companies[rand(@shipping_companies.size)]
  end

  def tracking_code
    (rand(26) + 65).chr + ('%06d' % rand(1000000))
  end

  def self.new_mixin(args)
    assignments = []
    args.each do |obj_key, obfuscate_key|
      value = if Obfuscator.instance.method(obfuscate_key).arity == 0
        "Obfuscator.instance.#{obfuscate_key}"
      else
        "Obfuscator.instance.#{obfuscate_key}(obj.#{obj_key})"
      end
      assignments.push "obj.#{obj_key} = #{value} if obj.attributes.member?('#{obj_key}')"
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

  def self.configure
    M2m::Rma.send :include, new_mixin( :fcompany => :company_name )
    M2m::RmaItem.send :include, new_mixin( :freason => :lipsum_sentence )
    M2m::SalesOrder.send :include, new_mixin( :fshipvia => :shipping_company,
                                              :fcustpono => :some_digits )
    M2m::SalesOrderItem.send :include, new_mixin( :fdesc => :part_description,
                                                  :fcustpart => :customer_part_number )
    M2m::Shipper.send :include, new_mixin( :fshipvia => :shipping_company,
                                           :fcustpono => :some_digits,
                                           :fbl_lading => :tracking_code )
    M2m::Receiver.send :include, new_mixin( :fpono => :tracking_code )
    M2m::PurchaseOrderItem.send :include, new_mixin( :fvpartno => :part_number )
    M2m::InventoryVendor.send :include, new_mixin( :fvpartno => :part_number )
    M2m::Customer.send :include, new_mixin( :fcompany => :company_name,
                                            :fcontact => :last_name,
                                            :fcfname => :first_name,
                                            :fmnotes => :lipsum_sentence,
                                            :ffax => :phone_number )
    M2m::Contact.send :include, new_mixin( :fcontact => :last_name,
                                           :fcfname => :first_name,
                                           :PhoneWork => :phone_number,
                                           :fcemail => :email,
                                           :fcfax => :phone_number)
    M2m::Item.send :include, new_mixin( :fdescript => :part_description )
    M2m::WorkCenter.send :include, new_mixin( :fcpro_name => :verb )
    M2m::Customer.class_eval <<-RUBY
      def self.customer_name(txt)
        Obfuscator.instance.company_name(txt)
      end
    RUBY
  end
end
