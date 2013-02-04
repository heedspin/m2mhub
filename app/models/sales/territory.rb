# == Schema Information
#
# Table name: sales_territories
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  sales_rep_name :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Sales::Territory < M2mhub::Base
  set_table_name 'sales_territories'
  scope :by_name, :order => 'name'

  def name_and_description
    @name_and_description ||= [name, description].select(&:present?).join( ' - ')
  end
  
  def rep_and_description
    @rep_and_description ||= [sales_rep_name.present? ? sales_rep_name : name, description.present? ? description : (sales_rep_name.present? ? name : nil)].select(&:present?).join( ' - ')
  end

  def name_and_sales_rep
    @name_and_sales_rep ||= [name, sales_rep_name].select(&:present?).join( ' - ')
  end
  
  def self.import
    # http://en.wikipedia.org/wiki/List_of_regions_of_the_United_States#Official_U.S._regions
    [ 
      ['Upstate New York', '', 'Propel Technology'],
      ['Mid-Atlantic', 'Eastern PA, New Jersey, and Delaware', 'SRG'],
      ['East North Central', 'Ohio, Indiana, Michigan, Western PA, Kentucky, and West Virginia', 'The Hofstetter Company'],
      ['Upper Midwest', 'Illinois, Wisconsin, and Minnesota', 'Synergistic Sales, Inc.'],
      ['Carolinas', 'North Carolina and South Carolina', 'Tech-Source, Inc.'],
      ['West North Central', 'Missouri, Kansas, Iowa, and Nebraska', 'MINK Associates Inc.'],
      ['South Central', 'Texas, Oklahoma, Arkansas, Louisiana, and Western Mississippi', 'Erickson Sales'],
      ['Mountain', 'Arizona, New Mexico, and Las Vegas', 'Straube, SW']
    ].each do |name, description, sales_rep_name|
      territory = Sales::Territory.find_by_name(name) || Sales::Territory.new(:name => name)
      territory.description = description
      territory.sales_rep_name = sales_rep_name
      territory.save!
    end
  end
end
