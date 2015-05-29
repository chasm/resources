require 'faker'

Category.destroy_all
Item.destroy_all

5.times do 
  Category.create(title: Faker::Commerce.department(1, true))
end

Category.all.each do |category|
  rand(5..20).times do 
    category.items.create(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, inventory: rand(1..100))
  end
end

Item.all.each do |item|
  rand(1..15).times do
    item.reviews.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, rating: rand(1..5))  
  end
end