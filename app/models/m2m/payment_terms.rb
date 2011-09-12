class M2m::PaymentTerms < ActiveHash::Base
  self.data = [
    {:key => 'A', :name => 'Net 30'},
    {:key => 'F', :name => '2% 10, Net 30'},
    {:key => 'I', :name => 'Net 60'},
  ]
end
