require "faker"

Customer.destroy_all
Note.destroy_all

30.times do
  Customer.create(name: Faker::Name.name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.phone_number)
end

users = Customer.all

120.times do
  user = users.sample
  length = Random.rand(2) + 1
  content = Faker::Lorem.paragraphs(length).join("\n\n")
  user.notes.create(content: content)
end
