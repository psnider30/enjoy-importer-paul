class Customer < ApplicationRecord
  has_many :orders
  has_many :shipping_addresses
  has_one :billing_address

  accepts_nested_attributes_for :shipping_addresses, :billing_address
end
