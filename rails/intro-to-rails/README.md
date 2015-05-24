- we want to build meowtown: 
- what are the resources?
	- cats
- what should we be able to do with these resources?
	- see all
	- see one
	- edit one
	- create one
	- delete one

- first we need an app, with a postgresql database, and using rspec instead of rack::test:
```rails new meowtown --database=postgresql -T```
- install rspec
```ruby
	### in gemfile
	group :development, :test do
  	gem 'rspec-rails', '~> 3.0'
	end
```
```
### in command line:
rails g rspec:install
```
- install shoulda-matchers
```
### in gemfile
group :test do
  gem 'shoulda-matchers', require: false
end
```
```
### in rails_helper
require 'shoulda/matchers'
```
- install faker
```
### in gemfile
group :test, :development do
	gem 'faker'
end
```
```
### in rails_helper
require 'faker'
```

- we need a cat model and corresponding migration now:
```rails g model cat name:string life_story:text image_url:string```
- ```rake db:migrate```, ```rake db:migrate RAILS_ENV=test```
- write simple model specs
```
require 'rails_helper'

RSpec.describe Cat, type: :model do

	let(:healthy_cat) { Cat.create(name: Faker::Name.name, life_story: Faker::Lorem.paragraph, image_url: Faker::Avatar.image) }
	let(:almost_dead_cat) { Cat.create(name: Faker::Name.name, life_story: Faker::Lorem.paragraph, image_url: Faker::Avatar.image, lives: 1) }

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
- and the model itself:
```
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
- and now we need a controller, lets start with the 'index' action
```rails g controller cats```
- to use our controller action, we need a route to that controller. a url and http verb to trigger the action.
- a proper restful route for an index action on the cats resource would be ```get '/cats', to: 'cats#index'```
- we'll put this in our routes file
```
get '/cats', to: 'cats#index'
```
- and run ```rake routes```
- let's also make this the root page, the one that people land on when they visit our site
```root to: 'cats#index'```

- and some controller tests:
```
require 'rails_helper'

RSpec.describe CatsController, type: :controller do

	describe "#index" do
		
		before do 
			5.times { Cat.create(name: Faker::Name.name, life_story: Faker::Lorem.paragraph, image_url: Faker::Avatar.image) }
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
and controller code:
```
class CatsController < ApplicationController

	def index
		@cats = Cat.all
	end

end
```
and add a view called ```index.html.erb``` to /views/cats

- now #show, route, controller tests, controller action, view





