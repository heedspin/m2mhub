# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def customer_number_url(custno)
    customer_url(:id => custno, :custno => true)
  end
end
