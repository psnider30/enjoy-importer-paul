class AddOrderIdToShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :shipping_addresses, :order_id, :integer
  end
end
