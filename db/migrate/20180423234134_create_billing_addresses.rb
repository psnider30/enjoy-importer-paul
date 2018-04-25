class CreateBillingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_addresses do |t|
      t.integer :customer_id
      t.string :street_address
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip

      t.timestamps
    end
  end
end
