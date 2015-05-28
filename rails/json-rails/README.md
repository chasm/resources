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

### our migrations
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
### and models
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
- - -

our public api will exist to be consumed by some fancy front-end javascript framework. 

For now, we want folx to be able to:
  - see a list of all items
  - see a list of our categories 
  - see a category, and all of its items
  - see a single item, and all of its reviews
  - create a review for an item
  
we can translate the above into RESTful rails routes:
```ruby
Rails.application.routes.draw do
  get '/items', to: 'items#index'
  get '/categories', to: 'categories#index'
  get '/categories/:category_id', to: 'categories#show'
  get '/items/:item_id', to: 'items#show'
  post '/items/:item_id/reviews', to: 'reviews#create'
```
    
  - - -
