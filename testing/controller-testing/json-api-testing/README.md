# json api testing lecture

- setup [code-example](./code-example). this is a copy of their 'build an api challenge' from the morning.
- introduce factory girl, and show them the ```factories.rb``` file in the ```/spec``` folder.
- walk through creating specs for a couple GET routes, and a POST route

## lecture notes [in progress]

this morning you built your first JSON api. in the past, we've built servers that return HTML. now we're building servers that return raw JSON data back, with the expectation that the client will render it however they want. our server returns the right data, and the client does the rest.

our controllers look a little different now, and so do our controller tests. in this lecture, we'll TDD our way through a couple of routes for that 'build-an-api' challenge from the morning.

for now, let's choose these and approach them one-by-one:
- [GET] list of users
- [GET] list of articles for a user
- [POST] create a new comment for an article by a user

before we jump into testing, a brief aside on factory girl

## factory girl

factory girl is a gem which provides simple methods to create objects from 'templates' that you get to define. these templates are called 'factories'

suppose you're trying to test that a user can 'like' a comment made by another user, on a product belonging to a category. in your ```before``` block you may have to setup the following:

```ruby
before do
  @category = Category.create(name: Faker::Commerce.department)
  @product = @category.products.create(name: Faker::Commerce.product_name, price: rand(1..100))
  @posting_user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
  @comment = @product.comments.create(body: Faker::Lorem.paragraph, user: @posting_user)
  @liking_user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
end
```

thats a lot of code. and if you had to set up a similar environment for a different set of tests, it would be even more code. 

factory girl provides an elegant solution to this (and plenty of additional features). [here are their docs](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)

in a separate file, which we might call ```factories.rb```, we can define factories for these objects:

```ruby
require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { "password" }
  end

  factory :category do
    name { Faker::Commerce.department }
  end

  factory :product do
    name { Faker::Commerce.product_name }
    price { rand(1..100) }
    category
  end

  factory :comment do
    body { Faker::Lorem.paragraph }
    user
    product
  end
end
```

we can use these factories to create objects like so:

```ruby
user = FactoryGirl.create(:user)
```

kind of cool. but what if we create a new comment:

```ruby
comment = FactoryGirl.create(:comment)
```

a comment with a faker-generated body will be added to the DB. but also, that comment will be associated with a ```user``` and ```product```, as defined by your ```user``` and ```product``` factories! that means also, that your new comment's product will be associated with a ```category``` also defined by factory girl. this is very convenient.

but what if we want to create a bunch of comments for a specific user, and not a random one that factory girl autogenerates for us? no problem.

```ruby
user = FactoryGirl.create(:user)
5.times { FactoryGirl.create(:comment, user: user) }
```

and for a specific product?

```ruby
user = FactoryGirl.create(:user)
product = FactoryGirl.create(:product)
5.times { FactoryGirl.create(:comment, user: user, product: product) }
```

and maybe our user always says the same thing in every comment.

```ruby
user = FactoryGirl.create(:user)
product = FactoryGirl.create(:product)
5.times { FactoryGirl.create(:comment, user: user, product: product, body: "i am yeezus") }
```

so, factory girl is convenient and flexible.

two other useful methods (there are so many more though) are:

```ruby
FactoryGirl.build(:user) # creates a new instance of user from your factory, but doesn't save it to the DB
FactoryGirl.attributes_for(:user) # returns a ruby Hash containing the attributes for a user as defined by your :user factory
```

## [GET] list of users
