# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

order1 = Order.create(partner_order_number: 001, partner_id: 1, customer_id: 1)
location1 = Location.create(location_number:10)
partner1 = Partner.create
customer1 = Customer.create(email: 'pbsnider@gmail.com')
customer1.create_shipping_address(street_address: '171 Constitution Dr', city: 'Menlo Park', state: 'CA', country:'U.S.', zip:'94025')

product1 = Product.create(sku: '123')

shipping_address = {street_address: '171 Constitution Dr', city: 'Menlo Park', state: 'CA', country:'U.S.', zip:'94025'}
