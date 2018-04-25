class BillingAddress < ApplicationRecord
  belongs_to :customer
  belongs_to :order

  # convert instance of BillingAddress to hash so return value can be used with assign_attributes
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
