require 'faker'

Cat.destroy_all

5.times { Cat.create(name: Faker::Name.name, product: Faker::Commerce.product_name) }