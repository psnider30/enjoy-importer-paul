
def import(file, partner)

  raise if filepath[-3..-1] != 'csv'

  CSV.foreach(filepath, headers: true, header_converters: CSV::HeaderConverters[:symbol]) do |row|
    customer = Customer.find_by(email: customer_profile.customer_id)
    location = Location.find_by(location_number: row[:location_number])

    # move order attribute assignment to top if have the attribute values. Include all attributes in find_or_initialize_by if feasible for system
    order = Order.find_or_initialize_by(partner_order_number: row[:order_number])
    order.partner_id = partner.id
    order.customer_id = customer.id

    billing_address = customer.billing_address

    # if the customers on file billing address is same as cvs shipping address for these fields, then set the rest of shipping address from billing address
    if billing_address.street_address == row[:shipping_address1] &&
       billing_address.city == row[:shipping_city] &&
       billing_address.zip == row[:shipping_zip]

       # convert the billing_address instance to hash and then build the shipping_adress instance associated with the customer from the billing_address_hash
       billing_address_hash = billing_address.instance_to_hash
       shipping_address = customer1.shipping_addresses.build(billing_address_hash)
    # if the inputted shipping address not same as billing address fields above and shipping_address1 and shipping_city filled in, then set shipping address from cvs file
    elsif row[:shipping_address1].present? && row[:shipping_city].present?

      # set shipping address attributes from cvs rows
      shipping_address.street_address = row[:shipping_address1]
      shipping_address.street_address_2 = row[:shipping_address2]
      shipping_address.city = row[:shipping_city]
      shipping_address.state = row[:shipping_state]
      shipping_address.country = row[:shipping_country]
      shipping_address.zip = row[:shipping_zip]

      shipping_address.save

    else
      shipping_address = nil
    end
    # shrink to single line if statements and avoid negating .blank? with .present?
    order.billing_address = billing_address if billing_address.present?
    order.shipping_address = shipping_address if shipping_address.present?
    order.save

    #split string of skus into array instead of counting commas and setting range of array. Much simpler and readable
    skus = row[:skus].split(',')
    skus.each do |sku|
      product = Product.find_or_create_by(sku: sku)
      order_item = product.order_items.create(order_id: order.id, location_id: location.id)
    end
  end #-->end loop of csv files
end #--> end import method
