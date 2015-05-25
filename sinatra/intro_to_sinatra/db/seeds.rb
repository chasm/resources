require 'faker'

20.times do
  Student.create(name: Faker::Name.name, biography: Faker::Lorem.paragraph)
end