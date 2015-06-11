require 'faker'

Task.destroy_all

10.times { Task.create(description:Faker::Lorem.sentence) }