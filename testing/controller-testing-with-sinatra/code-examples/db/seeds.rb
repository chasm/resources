require 'faker'

5.times { Item.create(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(1..100)) }