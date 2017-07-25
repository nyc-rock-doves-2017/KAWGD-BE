require 'faker'

Delivered.destroy_all
Pickup.destroy_all
Assigned.destroy_all
Order.destroy_all
User.destroy_all

# Merchants
i = 1
5.times do
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
i = 6
5.times do
  User.create(
    email: "#{i}@email.com",
    password: "password",
    phone_number: Faker::PhoneNumber.phone_number,
    user_type: "bike boy"
  )
  i += 1
end

# Orders
i = 1
5.times do
  Order.create(
    merchant_id: i,
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
  i += 1
end

i = 1
d = 6
5.times do
  Assigned.create(
    order_id: i,
    deliverer_id: d,
    assignment_time: DateTime.now
  )
  i += 1
  d += 1
end

i = 1
5.times do
  Pickup.create(
    assigned_id: i,
    pickup_time: DateTime.now
  )
  i += 1
end

i = 1
5.times do
  Delivered.create(
    assigned_id: i,
    delivered_time: DateTime.now
  )
  i += 1
end
