# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def m2m_customer_number_url(custno)
    m2m_customer_url(:id => custno, :custno => true)
  end
end
