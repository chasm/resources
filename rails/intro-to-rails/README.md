# intro to rails
we are going to build [meowtown](http://meowtown.herokuapp.com/) with rails

## create a rails app
```rails new meowtown --database=postgresql -T```

## install rspec 
```ruby
### gemfile
group :development, :test do
	gem 'rspec-rails', '~> 3.0'
end
```
```rails g rspec:install```

## install shoulda-matchers
```ruby
## gemfile
group :test do
	gem 'shoulda-matchers', require: false
end

## rails_helper
require 'shoulda/matchers'
```

## install faker
```ruby
### in gemfile
group :test, :development do
	gem 'faker'
end

### in rails_helper
require 'faker'
```
## install factory girl
- in rails helper, uncomment the following line:
```
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```
- paste the following in ```spec/support/factory_girl.rb```
```ruby
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```
- create a folder ```spec/factories```

## create a cat model and migration
- run: ```rails g model cat name:string life_story:text image_url:string```
- edit migration
```ruby
class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.text :life_story
      t.string :image_url
      t.integer :lives, default: 9
      
      t.timestamps null: false
    end
  end
end
```
- run ```rake db:migrate``` and ```rake db:migrate RAILS_ENV=test```

## write tests for cat model
- in ```spec/factories/cat.rb```
```ruby
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
```
- in ```spec/models/cat_spec.rb```
```ruby
require 'rails_helper'

RSpec.describe Cat, type: :model do

	let(:healthy_cat) { create(:cat) }
	let(:almost_dead_cat) { create(:cat_with_1_life) }

	describe "fields" do
		it { should have_db_column(:name).of_type(:string) }
		it { should have_db_column(:life_story).of_type(:text) }
		it { should have_db_column(:image_url).of_type(:string) }
		it { should have_db_column(:lives).of_type(:integer).with_options(default: 9) }
	end

	describe "validations" do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:life_story) }
		it { should validate_presence_of(:image_url) }
	end

	describe "methods" do
		describe "#lose_a_life!" do
			context "if cat has more than 1 life remaining" do
				it "decrements the cat's lives by 1" do
					healthy_cat.lose_a_life!
					expect(healthy_cat.lives).to eq(8)
				end
			end
			context "if cat has 1 life remaining" do
				it "removes the cat from the database" do
					almost_dead_cat.lose_a_life!
					expect(Cat.find_by_name(almost_dead_cat.name)).to be_nil
				end
			end
		end
	end

end
```
- in ```app/models/cat.rb```
```ruby
class Cat < ActiveRecord::Base

	validates :name, presence: true
	validates :life_story, presence: true
	validates :image_url, presence: true

	def lose_a_life!
		if self.lives > 1
			self.lives -= 1
			self.save
		else 
			self.destroy
		end
	end

end
```
## generate CatsController
- run: ```rails g controller cats```

### add '#index' action
- create a route for the action in ```config/routes.rb```
```ruby
get '/cats', to: 'cats#index'
```
- we'll also make this route the 'root route' of our application
```ruby
root to: 'cats#index'
```

- add controller specs:
```ruby
require 'rails_helper'

RSpec.describe CatsController, type: :controller do

	describe "#index" do

		before do 
			5.times { Cat.create(attributes_for(:cat)) }
			get :index
		end

		it { should respond_with(200) }
		it { should render_template(:index) }
		it "should assign @cats to all Cats in DB" do
			expect(assigns(:cats)).to eq(Cat.all)
		end

	end

end
```
add controller code:
```ruby
class CatsController < ApplicationController

	def index
		@cats = Cat.all
	end

end
```
add view: ```/views/cats/index.html.erb```

### add '#show' action
- create route:
```ruby
  get '/cats/:id', to: 'cats#show'
```
- controller specs
```ruby
	describe "#show" do

		before do
			@cat = Cat.create(attributes_for(:cat))
			get :show, id: @cat.id
		end

		it { should respond_with(200) }
		it { should render_template(:show) }
		it "should assign cat with specified id to @cat" do
			expect(assigns(:cat)).to eq(@cat)
		end

	end
```
- controller code
```
	def show
		@cat = Cat.find(params[:id])
	end
```
