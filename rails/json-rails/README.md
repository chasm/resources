# json apis with rails
we are going to build a simple, public api for an imaginary online marketplace.

- - -

this marketplace will have the following resources:
  - categories
    - title
  - items
    - category_id
    - name
    - description
    - price
    - inventory
  - reviews
    - item_id
    - title
    - body
    - rating

our categories have many items, and our items have many reviews.

our migrations
```ruby
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.timestamps null: false
    end
  end
end
```
```ruby
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :category
      t.string :name
      t.text :description
      t.decimal :price, :precision => 12, :scale => 2
      t.integer :inventory
      t.timestamps null: false
    end
  end
end
```
```ruby
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :item
      t.string :title
      t.text :body
      t.integer :rating
      t.timestamps null: false
    end
  end
end
```
and models
```ruby
class Category < ActiveRecord::Base
  has_many :items
end
```
```ruby
class Item < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
end
```
```ruby
class Review < ActiveRecord::Base
  belongs_to :item
end
```
and a seeds file
```ruby
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
```
- - -
our public api will exist to be consumed by some fancy front-end javascript framework. 

for now, we want folx to be able to:
  - see a list of all items
  - see a list of our categories 
  - see a category, and all of its items
  - see a single item, and all of its reviews
  - create a review for an item
  
our routes:
```ruby
Rails.application.routes.draw do
  get '/items', to: 'items#index', as: 'items'
  get '/categories', to: 'categories#index', as: 'categories'
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/items/:id', to: 'items#show', as: 'item'
  post '/items/:item_id/reviews', to: 'reviews#create', as: 'item_reviews'
end
```
- - -
our routes refactored:
```ruby
resources :categories, only: [:index, :show]
resources :items, only: [:index, :show] do
  resources :reviews, only: :create
end
```
our routes namespaced:
```ruby
Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :categories, only: [:index, :show]
      resources :items, only: [:index, :show] do
        resources :reviews, only: :create
      end
    end
  end
end
```
- - -
our routes are currently mapped to non-existent controllers. 

let's bring those controllers into existence:

```
rails g controller api/v1/categories index show --skip-routes --no-helper --no-template-engine --no-assets
rails g controller api/v1/items index show --skip-routes --no-helper --no-template-engine --no-assets
rails g controller api/v1/reviews create --skip-routes --no-helper --no-template-engine --no-assets
```

let's make the routes we've made so far completely public. no authenticity token will be needed to hit these routes.

we can do this by adding ```skip_before_filter :verify_authenticity_token``` to all our controllers.

```ruby
class Api::V1::CategoriesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
  end

  def show
  end
end
```
```ruby
class Api::V1::ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
  end

  def show
  end
end
```
```ruby
class Api::V1::ReviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def create
  end
end
```
or ... we can put it in an 'Api::V1::ApiController' and have our other controllers inherit from it.

```rails g controller api/v1/api --no-helper --no-template-engine --no-assets```
```ruby
class Api::V1::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
end
```
```ruby
class Api::V1::CategoriesController < Api::V1::ApiController
  def index
  end

  def show
  end
end
```
```ruby
class Api::V1::ItemsController < Api::V1::ApiController
  def index
  end

  def show
  end
end
```
```ruby
class Api::V1::ReviewsController < Api::V1::ApiController
  def create
  end
end
```

- - -

now that our controllers have been created, we can start working on the actions

#### GET '/api/v1/categories' - api/v1/categories#index
```ruby
def index
  render json: Category.all
end
```
this will render all our categories as json. perfect. but what if we don't care about the timestamps? 

we can always remove fields from our json response using the ```.as_json``` method with the ```except``` option
```ruby
def index
  render json: Category.all.as_json(except: [:created_at, :updated_at])
end
```

#### GET '/api/v1/categories/:id' - api/v1/categories#show

when we show a category, we probably also want to show a list of its items as well.

we can do this with ```.as_json```'s ```include``` option
```ruby
def show
  category = Category.find_by_id(params[:id])
  render json: category.as_json(
    except: [:created_at, :updated_at], 
    include: :items
  )
end
```
we can remove any unnecessary or redundant fields from our items like so:
```ruby 
def show
  category = Category.find_by_id(params[:id])
  render json: category.as_json(
    except: [:created_at, :updated_at], 
    include: { 
     items: { except: [:created_at, :updated_at, :category_id] } 
    }
  )
end
```
what if a bad request is made?
```ruby
def show
  if category = Category.find_by_id(params[:id])
    render json: category.as_json(
      except: [:created_at, :updated_at], 
      include: { 
       items: { except: [:created_at, :updated_at, :category_id] } 
      }
    )
  else 
    render status: 404, json: { 
      error: 'requested category does not exist' 
    }
  end
end
```
