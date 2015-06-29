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

factory girl is a gem which provides simple methods to create objects from 'templates' that you get to define.

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

factory_girl provides an elegant solution to this (and plenty of additional features). [here are their docs](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)

in a separate file, which we might call ```factories.rb```, we can define factories for these objects 

## [GET] list of users

