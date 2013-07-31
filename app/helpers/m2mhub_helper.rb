module M2mhubHelper
  def m2m_customer_number_url(custno)
    m2m_customer_url(:id => custno, :custno => true)
  end
end
