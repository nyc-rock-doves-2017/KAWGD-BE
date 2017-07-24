require 'faker'

# Merchants
5.times do
  i = 1
  User.create(
    email: "#{i}@email.com",
    password: "password",
    phone_number: Faker::PhoneNumber.phone_number,
    user_type: "merchant",
    street_address: "48 Wall Street",
    city_town: "New York City",
    state: "NY",
    zipcode: "10001",
    country: "United States"
  )
  i += 1
end

# Bike Boys
5.times do
  i = 6
  User.create(
    email: "#{i}@email.com",
    password: "password",
    phone_number: Faker::PhoneNumber.phone_number,
    user_type: "bike boy"
  )
  i += 1
end

# Orders
10.times do
  o = Order.create(
    merchant_id: 1,
    items: "Burritos",
    total_price: 6,
    cust_name: Faker::Name.name,
    cust_street_ad: "420 High Street",
    cust_city_town: "New York City",
    cust_state: "NY",
    cust_zipcode: "10001",
    cust_country: "United States",
    cust_phone_number: Faker::PhoneNumber.phone_number
  )
end

Assigned.create(
  order_id: 1,
  deliverer_id: rand(6..10),
  assignment_time: DateTime.now
)


Pickup.create(
  assigned_id: 1,
  pickup_time: DateTime.now
)

Delivered.create(
  assigned_id: 1,
  delivered_time: DateTime.now
)
