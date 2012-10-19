# Usage: ./script/runner ./script/stagnant_companies.rb
#
class StagnantCompanies
  def run
    stagnant_date = Date.current.advance(:months => -6)
    active_companies = []
    M2m::SalesOrder.ordered_since(stagnant_date).all(:include => :customer).each do |so|
      company_name = so.customer.company_name.downcase.strip
      unless active_companies.include?(company_name)
        active_companies.push company_name
      end
    end
    stagnant_companies = []
    M2m::Customer.all.each do |customer|    
      company_name = customer.company_name.downcase.strip
      unless active_companies.include?(company_name) || stagnant_companies.include?(company_name)
        stagnant_companies.push(company_name)
      end
    end
    puts "Active companies since: #{stagnant_date}"
    puts active_companies.sort.map(&:titleize).join("\n")
    puts "Stagnant companies since: #{stagnant_date}"
    puts stagnant_companies.sort.map(&:titleize).join("\n")
    0
  end
end

exit StagnantCompanies.new.run
