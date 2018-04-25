class BillingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :order

  #sets billing_address attribute to be same as shipping_adress or cvs hash
  def set_same_as_shipping_address(shipping_address_hash)
    shipping_address_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
  end

   def instance_to_hash
     billing_address = {}
     billing_address[:street_address] = street_address
     billing_address[:street_address_2] = street_address_2
     billing_address[:city] = city
     billing_address[:state] = state
     billing_address[:country] = country
     billing_address[:zip] = zip
     billing_address
   end

end
