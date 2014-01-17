# The source of the part:
# 
# M = Make
# The part is specifically made for a sales order rather than taken from stock.
# 
# B = Buy
# The part is normally purchased only when it is required as a sales order item or when it is purchased specifically for use on a job order.
# 
# S = Stock
# Parts that are kept in inventory regardless of whether they are assemblies (made) or purchased materials.
# 
# P = Phantom
# Indicates that this part is a collection of other parts, but is either never stocked or is never processed via a separate assembly job order. When used on a Bill of Material, this part will be replaced by its components.
# 

require 'plutolib/active_hash_methods'
class M2m::ItemSource < ActiveHash::Base
  self.data = [
    {:key => 'M', :name => 'Make'},
    {:key => 'B', :name => 'Buy'},
    {:key => 'S', :name => 'Stock'},
    {:key => 'P', :name => 'Phantom'},
  ]
  include Plutolib::ActiveHashMethods
end
