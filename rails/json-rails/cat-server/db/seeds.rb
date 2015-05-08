require 'faker'

5.times { Cat.create(name: Faker::Name.name, bitcoin: rand(0.01..100.0))}