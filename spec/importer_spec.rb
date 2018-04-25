require_relative '../lib/paul_s_importer.rb'
require 'pry'

# test do not run the import method, but instead mimic the logic
describe 'importer tests: ' do
  let(:customer1) { Customer.create(email: 'pbsnidergmail.com') }
  let(:billing_address1) {customer1.create_billing_address(
    street_address: '171 Constitution Dr',
    city: 'Menlo Park',
    state: 'CA',
    country:'U.S.',
    zip:'94025'
    )}
  let(:location1) { Location.create(location_number: 10) }
  let(:partner1) { Partner.create }
  let(:order1) { Order.create(
    partner_order_number: 001,
    partner_id: partner1.id,
    customer_id: customer1.id
    )}
  let(:product1) { Product.create(sku: SecureRandom.alphanumeric(4)) }

  it "assigns the billing_address from the customer billing address" do
    billing_address = customer1.billing_address
    expect(billing_address).to eq (customer1.billing_address)
  end

  it "assigns the shipping_address from the billing_adress if street_address, city, zip rows are same as in biling_address" do
    billing_address = billing_address1
    shipping_address1_row = '171 Constitution Dr'
    shipping_city_row = 'Menlo Park'
    shipping_zip_row = '94025'

    if billing_address.street_address == shipping_address1_row &&
       billing_address.city == shipping_city_row &&
       billing_address.zip == shipping_zip_row

       billing_address_hash = billing_address.instance_to_hash
       shipping_address = customer1.shipping_addresses.build
       shipping_address.set_same_as_billing_address(billing_address_hash)
     end
    expect(shipping_address.street_address).to eq(billing_address1.street_address)
    expect(shipping_address.instance_of?(ShippingAddress)).to eq(true)
  end

  it "assigns billing_address from rows if different address and shipping_address1 and shipping_city rows are present" do
    billing_address = billing_address1
    shipping_address1_row = '660 Palo Alto Ave'
    shipping_address2_row = 'Apt B'
    shipping_city_row = 'Palo Alto'
    shipping_state_row = 'CA'
    shipping_country_row = 'U.S.'
    shipping_zip_row = '94301'

    if billing_address.street_address == shipping_address1_row &&
       billing_address.city == shipping_city_row &&
       billing_address.zip == shipping_zip_row

       shipping_address = billing_address

    elsif shipping_address1_row.present? && shipping_city_row.present?
      shipping_address = {}
      shipping_address[:street_address] = shipping_address1_row
      shipping_address[:street_address_2] = shipping_address2_row
      shipping_address[:city] = shipping_city_row
      shipping_address[:state] = shipping_state_row
      shipping_address[:country] = shipping_country_row
      shipping_address[:zip] = shipping_zip_row
    end
     expect(shipping_address).not_to eq(billing_address1)
     expect(shipping_address[:street_address_2]).to eq('Apt B')
  end

  it 'does not assign values for shipping_address if different address and shipping_address1 and shipping_city rows are not present' do
    shipping_address1_row = ''
    shipping_city_row = ''
    shipping_zip_row = ''
    billing_address = billing_address1
    if billing_address.street_address == shipping_address1_row &&
       billing_address.city == shipping_city_row &&
       billing_address.zip == shipping_zip_row

       shipping_address = billing_address

    elsif shipping_address1_row.present? && shipping_city_row.present?
      shipping_address = {}
    else
      shipping_address = nil
    end
    expect(shipping_address).to eq(nil)
    expect(shipping_address).not_to eq(billing_address1)
    expect(shipping_address).not_to eq({})
  end

  it "associates billing_address and shipping_address with order if they are present respectively" do
    order = order1
    billing_address = billing_address1
    billing_address_hash = billing_address.instance_to_hash
    shipping_address = customer1.shipping_addresses.build(billing_address_hash)

    order.billing_address = billing_address if billing_address.present?
    order.shipping_address = shipping_address if shipping_address.present?

    expect(order.billing_address).to eq(billing_address1)
    expect(order.shipping_address).to eq(shipping_address)
    expect(order.shipping_address.street_address).to eq(order.billing_address.street_address)
  end

  it "creates products and order items associated with products from a string of skus separated by commas" do
    sku_rows = 'abc-1,def-2,ghi-3,jkl-4'
    skus = sku_rows.split(',')
    skus.each do |sku|
      product = Product.find_or_create_by(sku: sku)
      order_item = product.order_items.create(order_id: order1.id, location_id: location1.id)
    end
    expect(Product.last.sku).to eq(skus.last)
    expect(OrderItem.last.order_id).to eq(order1.id)
    expect(OrderItem.last).to eq(Product.last.order_items.last)
  end

end
