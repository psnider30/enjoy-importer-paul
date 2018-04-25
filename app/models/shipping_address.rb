class ShippingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :order

  #set shipping_address attribute to be same as billing_address hash
  def set_same_as_billing_address(billing_address_hash)
     billing_address_hash.each do |attr, value|
       self.send("#{attr}=", value)
     end
   end

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
