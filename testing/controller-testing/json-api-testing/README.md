# json api testing lecture

- setup [code-example](./code-example). this is a copy of their 'build an api challenge' from the morning.
- introduce factory girl, and show them the ```factories.rb``` file in the ```/spec``` folder.
- walk through creating specs for a couple GET routes, and a POST route

## lecture notes

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
  category = Category.create(name: Faker::Commerce.department)
  product = category.products.create(name: Faker::Commerce.product_name, price: rand(1..100))
  posting_user = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
  @comment = @product.comments.create(body: Faker::Lorem.paragraph, user: posting_user)
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

a comment with a faker-generated body will be added to the DB. but also, that comment will be associated with a ```user``` and ```product```, as defined by your ```user``` and ```product``` factories! that means also, that your new comment's product will be associated with a ```category``` also defined by factory girl. 

this means that we can reduce our ```before``` block above to:

```ruby
before do
  @comment = FactoryGirl.create(:comment)
  @liking_user = FactoryGirl.create(:user)
end
```

convenient.

factory girl is flexible too. suppose we wanted to create a bunch of comments for a specific user, and not a random one that factory girl autogenerates for us? no problem.

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

okay, our first route.

let's first set up our spec file:

```ruby
require 'spec_helper'
require_relative '../factories.rb'

describe "api_controller" do
  before do 
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end
end
```

notice that we require_relative the '../factories.rb' file provided to us in the 'build-an-api' challenge. that file looks like this:

```ruby
require 'factory_girl'
require 'faker'

FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
  end

  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }
    user
  end

  factory :comment do
    body { Faker::Lorem.paragraph }
    user
    article
  end

end
```

now we need to think of a good route name for getting a list of users. the relevant resource here is users, and the action we perform on that resource is a "GET". so ```get '/users'``` seems appropriate.

but maybe we want to namespace this route to a particular version.

```get '/api/v1/users/'```

now that we've chosen a name for this route, lets add a describe block and some expectations for it in our spec file:

```ruby
require 'spec_helper'
require_relative '../factories.rb'

describe "api_controller" do
  before do 
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end

  describe "get '/api/v1/users'" do
    it "returns all users as json" do

    end
  end
end
```

that's about all that this route does. it returns all users as json. now, let's add a before block and a test.

```ruby
require 'spec_helper'
require_relative '../factories.rb'

describe "api_controller" do
  before do 
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end

  describe "get '/api/v1/users'" do
    before do
      5.times { FactoryGirl.create(:user) }
      get "/api/v1/users"
    end

    it "returns all users as json" do
      expect(last_response.body).to eq(User.all.to_json)
    end
  end
end
```

simple. after adding some users to the test DB and making a get request to '/api/v1/users', we expect the body of our server response to be all the users in our DB, rendered as json.

to satisfy our tests, we add the following to our controller:

```ruby
require 'sinatra/json'

get "/api/v1/users" do
  json User.all
end
```

## [GET] list of articles for a user

onto the next route.

again, we will decide on a name of our route. the relevant resource here is all the articles belonging to a specific user. the action we're performing on this resource is a 'GET'. 

following RESTful naming conventions, are route might be called ```get '/api/v1/users/:user_id/articles'```

we'll add a describe block and some expectations for this route in our spec file:

```ruby
  
  ...

  describe "get '/api/v1/users/:user_id/articles'" do
    it "returns all articles belonging to specifed user, as json" do

    end
  end

  ...

```

this is really our only expectation for this route.

next, we'll add a before block and a test

```ruby

  ...

  describe "get '/api/v1/users/:user_id/articles'" do
    before do
      @user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:article, user: @user) }
      get "/api/v1/users/#{@user.id}/articles"
    end

    it "returns all articles belonging to specifed user, as json" do
      expect(last_response.body).to eq(@user.articles.to_json)
    end
  end

  ...

```

and add the following to our controller to satisfy our test:

```ruby
get "/api/v1/users/:user_id/articles" do
  user = User.find(params[:user_id])  
  json user.articles
end
```

nice and simple. there is less to think about there are no views involved.

## [POST] create a new comment for an article by a user

posts requests are a little more interesting to test. this is because the user has the opportunity to screw up a post request. they can send valid or invalid parameters along with the request.

a good name for this route would be:

```
post '/api/v1/articles/:article_id/comments'
```

the relevant resource here is the comments belonging to a specific article. the action we're performing on that resource is a 'POST'.

but, hold on, articles belong to users right? so shouldn't our route be more like: 

```
post '/api/v1/users/:user_id/articles/:article_id/comments'
```

well, you could do it this way. but, an article is permanently coupled to its user (which we can think of as an author). an article has a ```user_id``` attribute. so although we could nest our articles resource under the users resource, there is no practical need to. it is redundant.

so we'll leave it at:

```
post '/api/v1/articles/:article_id/comments'
```

now, let's create a describe for our route, and outline some expectations for it. we remember that there are too types of requests we can make -- a valid request, and an invalid request. so we'll have some ```context``` blocks as well.

```ruby

...

  describe "post '/api/v1/articles/:article_id/comments'" do
    context "with valid params" do
      it "creates a new comment with specified params" do

      end

      it "returns the new comment, as json" do

      end
    end

    context "with invalid params" do
      it "does not create a new comment" do
      
      end

      it "returns status code 400" do

      end

      it "returns an error message" do

      end
    end
  end

...

```

now, we'll create before blocks and add some tests.

```ruby

...

  describe "post '/api/v1/articles/:article_id/comments'" do
    context "with valid params" do
      before do
        @article = FactoryGirl.create(:article)
        commentor = FactoryGirl.create(:user)
        @valid_comment_params = { body: Faker::Lorem.sentence, user_id: commentor.id}
        post "/api/v1/articles/#{@article.id}/comments", @valid_comment_params
        @comment = Comment.find_by(@valid_comment_params)
      end

      it "creates a new comment with specified params" do
        expect(@comment).to be_truthy
      end

      it "returns the new comment, as json" do
        expect(last_response.body).to eq(@comment.to_json)
      end
    end

    context "with invalid params" do
      before do
        @article = FactoryGirl.create(:article)
        post "/api/v1/articles/#{@article.id}/comments", { water: false }
      end

      it "does not create a new comment" do
        expect(Comment.all.length).to eq(0)
      end

      it "returns status code 400" do
        expect(last_response.status).to eq(400)
      end

      it "returns an error message" do
        expect(last_response.body).to include("errors")
      end
    end
  end

...

```

and we'll add the following to our controller to make these tests pass:

```ruby
post "/api/v1/articles/:article_id/comments" do
  article = Article.find(params[:article_id])
  comment = article.comments.new(body: params[:body], user_id: params[:user_id])
  if comment.save
    json comment
  else
    body json({"errors" => comment.errors.full_messages})
    status 400
  end
end
```

## summary

our specs:

```ruby
require 'spec_helper'
require_relative '../factories.rb'

describe "api_controller" do
  before do 
    User.destroy_all
    Article.destroy_all
    Comment.destroy_all
  end

  describe "get '/api/v1/users'" do
    before do
      5.times { FactoryGirl.create(:user) }
      get "/api/v1/users"
    end

    it "returns all users as json" do
      expect(last_response.body).to eq(User.all.to_json)
    end
  end

  describe "get '/api/v1/users/:user_id/articles'" do
    before do
      @user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:article, user: @user) }
      get "/api/v1/users/#{@user.id}/articles"
    end

    it "returns all articles belonging to specifed user, as json" do
      expect(last_response.body).to eq(@user.articles.to_json)
    end
  end

  describe "post '/api/v1/articles/:article_id/comments'" do
    context "with valid params" do
      before do
        @article = FactoryGirl.create(:article)
        commentor = FactoryGirl.create(:user)
        @valid_comment_params = { body: Faker::Lorem.sentence, user_id: commentor.id}
        post "/api/v1/articles/#{@article.id}/comments", @valid_comment_params
        @comment = Comment.find_by(@valid_comment_params)
      end

      it "creates a new comment with specified params" do
        expect(@comment).to be_truthy
      end

      it "returns the new comment, as json" do
        expect(last_response.body).to eq(@comment.to_json)
      end
    end

    context "with invalid params" do
      before do
        @article = FactoryGirl.create(:article)
        post "/api/v1/articles/#{@article.id}/comments", { water: false }
      end

      it "does not create a new comment" do
        expect(Comment.all.length).to eq(0)
      end

      it "returns status code 400" do
        expect(last_response.status).to eq(400)
      end

      it "returns an error message" do
        expect(last_response.body).to include("errors")
      end
    end
  end
end
```

and our controller code:

```ruby
require 'sinatra/json'

get "/api/v1/users" do
  json User.all
end

get "/api/v1/users/:user_id/articles" do
  user = User.find(params[:user_id])  
  json user.articles
end

post "/api/v1/articles/:article_id/comments" do
  article = Article.find(params[:article_id])
  comment = article.comments.new(body: params[:body], user_id: params[:user_id])
  if comment.save
    json comment
  else
    body json({"errors" => comment.errors.full_messages})
    status 400
  end
end
```