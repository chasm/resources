FactoryGirl.define do

  factory :cat do 

    name Faker::Name.name 
    life_story Faker::Lorem.paragraph 
    image_url Faker::Avatar.image

    factory :cat_with_1_life do
      lives 1
    end

  end

end