class AddOrderIdToBillingAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :billing_addresses, :order_id, :integer
  end
end
