class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :order

   # convert instance of ShippingAddress to hash so return value can be used with assign_attributes
   def instance_to_hash
     shipping_address = {}
     shipping_address[:street_address] = street_address
     shipping_address[:street_address_2] = street_address_2
     shipping_address[:city] = city
     shipping_address[:state] = state
     shipping_address[:country] = country
     shipping_address[:zip] = zip
     shipping_address
   end

end
