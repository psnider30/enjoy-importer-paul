class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :partner_order_number
      t.integer :customer_id
      t.integer :partner_id

      t.timestamps
    end
  end
end
