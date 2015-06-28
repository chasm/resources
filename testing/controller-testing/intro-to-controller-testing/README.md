# intro to controller testing lecture

controller testing is relatively simple. let's think briefly on what controllers do and what we should be testing for. 

controllers:
  - render html views
  - redirect to other controller actions
  - manipulate the session
  - interact with models to read from and write to the DB

can we test for all these things? fortunately, yes. we can test for all of them. so, let's begin.

we'll start by setting up the DB for a generic items server. our items are simple, they have a name, description and price.

```ruby
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 12, scale: 2
      t.timestamps
    end
  end
end
```
```ruby
class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end
```

now that we have an Item model and corresponding migration defined, we can start constructing a controller. this controller will be minimal. we'll have a ```get '/items'``` and a ```post '/items'``` route, for reading and writing to our DB's 'items' resource, respectively.

```ruby
get '/items' do
end

post '/items' do
end
```

and let's outline some expectations for these controller actions

```ruby
get '/items' do
  # should render an index.erb view
  # that index.erb view should contain all the items in our DB
end

post '/items' do
  # should create a new item with name, price, and description from params
  # should then redirect to the '/items' action
end
```

looks good, but users aren't perfect. they can enter invalid info. so what do we do if the user creates an invalid item -- say, something with no name and a negative price.

```ruby
get '/items' do
  # should render an index.erb view
  # that index.erb view should contain all the items in our DB

  # if error in session
    # index.erb view should also contain errors
    # session should be cleared of errors
end

post '/items' do
  # if valid params
    # should create a new item with name, price, and description from params
  # if invalid params
    # should not(!) create a new item 
    # should store an error in the session

  # should redirect to the '/items' action
end
```

okay, this looks good. we have one page. that page will presumably have a form allowing the user to create a new item. that page should also have something like a list of all items in our DB. 

if we submit the form with valid params, a new item is added to our DB, and will be redirected to our singular items page, containing our new item.

if we submit the form with invalid params, the invalid will not be added to our DB, and we will be redirected to our singular items page, where a little error message will appear informing us that we've screwed up.

we have some clear expectations for our controllers now. so let's outline our tests.

we'll start by translating our expectations into RSpec 'describes', 'contexts', and 'its'

```ruby
require 'spec_helper'

describe "ItemsController" do

  describe "GET /items" do

    context "if no error stored in the session" do

      it "has http status code of 200" do
      end

      it "renders the items index page" do
      end

      it "renders all items on the page" do
      end

    end

    context "if error in the session" do

      it "has http status code of 200" do
      end

      it "renders the items index page" do
      end

      it "renders all items on the page" do
      end

      it "renders error message on the page" do
      end

      it "clears the session of errors" do
      end

    end

  end

  describe "POST /items" do

    context "if valid request" do

      it "returns http status code of 302" do
      end

      it "creates an item in the database with specifed params" do
      end

      it "redirects to /items" do
      end

    end

    context "if invalid request" do

      it "returns http status code of 302" do
      end

      it "does not create an item in the database with specified params" do
      end

      it "redirects to /items" do
      end

      it "stores error in the session" do
      end

    end

  end

end
```

a brief primer/review:
  - 'describe' blocks are used to group sets of tests. a describe block will typically relate to an object, method, process, etc.
  - 'context' blocks are functionally identical to 'describe' blocks. but we use context blocks to describe how an object, method, process behaves under a certain context. 
  - 'it' blocks are for our tests. if no expectations inside the 'it' block fail, the test passes. otherwise, it fails.

in controller tests, the outer describe block pertains to our controller, and inside that describe block, we'll have an additional describe block for each controller action. if any controller actions exhibit different behaviors with different contexts, we'll have an additional layer of context blocks.

now would be a good time to:
reset the DB: ```rake db:reset```
migrate the test database: ```rake db:test:prepare```

let's tackle the ```GET '/items'``` tests first, assuming that there are no errors in the session:

```ruby
describe "GET /items" do

  context "if no error stored in the session" do

    it "has http status code of 200" do
    end

    it "renders the items index page" do
    end

    it "renders all items on the page" do
    end

  end

  . . .

end
```

this first test about the status code is a very simple test to verify that the route exists. if the route doesn't exist, and we try to make a request to it, our server will return an http status code of 404, meaning the requested resource was not found. though, if the route does exist, we will get a status code of 200 from the server, meaning 'everything is ok'.

before we can test anything, we'll need to actually make that request. so how do we make a request to our server with RSpec? Turns out its very simple.

```ruby
it "has http status code of 200" do
  get '/items'    
end
```

its actually that easy lol.

now, where do we get the status code returned from the server? the status code, and a wealth of other information about the server response can be found in a preset variable called ```last_response```. highly encouraged that you print last_response and see what information it contains. 

last_response is an object. and as we'd expect from an object, it has attributes and methods. one of those attributes is ```.status``` which returns exactly the status code that we want. we expect that this status code will be 200.

```ruby
it "has http status code of 200" do
  get '/items'   
  expect(last_response.status).to eq(200)
end
```

adding the following to our controller will make this test pass.
```ruby
get '/items' do
end
```

let's tackle the next test in this context block:
```ruby
it "renders the items index page" do
  # ???
end
```

take another look at the ```last_response``` object. it has another attribute ```.body```. body returns the body of the html returned by the server. body is a string. we can use the body attribute to determine whether the controller has rendered the correct view. 

for example, let's decide right now that the index page will have at the very top of it: ```<h1>Items Page</h1>```. let's also decide that the index page is the only page that will contain this h1 tag. if we agree on this, we can write the following test:

```ruby
it "renders the items index page" do
  get '/items'
  expect(last_response.body).to include('<h1>Items Page</h1>')
end
```

based on our previous assumption, if last_response's body contains that h1 tag, the index.erb view must have been rendered. there is no other circumstance where this is possible.

to make this test pass we must create an index.erb view and have our controller render that view:

```ruby
# app/views/index.erb
<h1>Items Page</h1>
```

```ruby
get '/items' do
  erb :index
end
```


- outline (documentation in progress)
  - 'let' statements
  - migrating test database
  - division of controller spec into actions
  - what can we test for: 
    - status 
    - redirection 
    - rendering 
    - changes to the DB
    - changes to the session
  - rack mock request format
  - last_request and last_response objects
  - reading from and writing to the session

