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

## create seed data
-  in ```db/seeds.rb```
```ruby
require 'faker'

10.times { Cat.create(name: Faker::Name.name, life_story: Faker::Lorem.paragraph, image_url: Faker::Avatar.image) }
```
- run ```rake db:seed```

## generate necessary routes
- our resource is 'cats'
- the actions we'll perform on that resource are:
	- read
		- get #index (show all cats)
		- get #show (show one cat)
	- create
		- get #new (render a form to create a new cat)
		- post #create (create a new cat)
	- update
		- get #edit (render a form to edit a cat)
		- patch #update (edit a cat)
- to generate these routes, we add the following to ```config/routes.rb```
```ruby
  resources :cats, except: :destroy
```
- and maybe we'll set the root page of our application to the cats index page
```ruby
  resources :cats, except: :destroy
  root to: 'cats#index'
```
- run ```rake routes``` to see the generated routes

## generate CatsController
- we've created a bunch of routes, each of which points to a specific controller action. Now we need to actually create those controller actions. We can start by generating a controller.
```rails g controller cats```

### add '#index' action

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
- add controller code:
```ruby
class CatsController < ApplicationController

	def index
		@cats = Cat.all
	end

end
```
- add view: ```/views/cats/index.html.erb```
```
<h1>meowtown</h1>

<ul>
  <% @cats.each do |cat| %>
    <li>
      <h2><%= cat.name %></h2>
      <img src='<%=cat.image_url%>' />
      <p>lives left: <%= cat.lives %></p>
    </li>
  <% end %>
</ul>
```

### add '#show' action
- add specs
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
- add controller action
```ruby
	def show
		@cat = Cat.find(params[:id])
	end
```
- add view in ```app/views/show.html.erb```
```
<h1><%= @cat.name %></h1>

<img src='<%= @cat.image_url %>' />

<h2>Life Story:</h2>

<p><%= @cat.life_story %></p>
```

### link the 'index' and 'show' views!
- in ```index.html.erb```, we can add links to the show pages of each cat
```ruby
<h1>meowtown</h1>

<ul>
  <% @cats.each do |cat| %>
    <li>
      <h2><%= cat.name %></h2>
      <img src='<%=cat.image_url%>' />
      <p>lives left: <%= cat.lives %></p>
      <%= link_to('show this cat', cat_path(cat)) %>
    </li>
  <% end %>
</ul>
```
- in ```show.html.erb```, add a 'back' button
```
<h1><%= @cat.name %></h1>

<img src='<%= @cat.image_url %>' />

<h2>Life Story:</h2>

<p><%= @cat.life_story %></p>

<%= link_to('back', cats_path) %>
```

### add '#new' action
- this is going to render a form allowing us to create a new cat
- write specs
```ruby
  describe "#new" do

    before do
      get :new
    end

    it { should respond_with(200) }
    it { should render_template(:new) }

  end
```
- create action in controller
```ruby
def new
end
```
- create view, in ```views/cats/new.html.erb```
```
<h1>create a cat</h1>

<%= form_for :cat, url: cats_path do |f| %>
  <p>
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </p>
  <p>
    <%= f.label :life_story %><br>
    <%= f.text_area :life_story %>
  </p>
  <p>
    <%= f.label :image_url %><br>
    <%= f.text_field :image_url %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>

<%= link_to('back', cats_path) %>
```
### add #create action
- we have a form, rendered by our new action. though, we currently have nowhere to submit that form to. we need to make our #create action
- write specs
```ruby
  describe "#create" do

    context "if valid params" do

      before do
        @cat_params = attributes_for(:cat)
        post :create, { cat: @cat_params }
      end

      it { should respond_with(302) }
      it "should redirect to the new cat's page" do
        cat = Cat.find_by(@cat_params)
        expect(response).to redirect_to("/cats/#{cat.id}")
      end
      it "creates a new cat with specified params" do
        expect(Cat.find_by(@valid_params)).to be_truthy
      end

    end

    context "if invalid params" do

      before do 
        post :create, { cat: {name: "test"} }
      end

      it { should respond_with(400) }
      it { should render_template(:new) }
      it "should not create a new cat" do
        expect(Cat.find_by_name("test")).to be_nil
      end

    end

  end
```
- create controller action
```ruby
  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_path
    else
      render 'new', status: 400
    end
  end

  private

    def cat_params
      params.require(:cat).permit(:name, :life_story, :image_url)
    end
```
- visit 'localhost:3000/cats/new' and attempt to make a new cat. 
- if we ever try to make a cat incorrectly, we'd like to have some error messages to let us know what we did wrong. those error messages are still stored in our unsaved @cat object, so we can access them in the view.
- in ```new.html.erb```, we'll add the following
```
<% if @cat.errors.any? %>
    <ul>
      <% @cat.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
<% end %>
```
- great, now we'll see error messages if any exist. But what if we visit the 'new' page for the first time? There is no cat object saved in @cat. The view will throw an error. 
- So, in our controller's new action we'll add:
```ruby
  def new
    @cat = Cat.new
  end
```
- and we'll update our specs:
```ruby 
  describe "#new" do

    before do
      get :new
    end

    it { should respond_with(200) }
    it { should render_template(:new) }
    it "should assign an instance of Cat to @cat" do
      expect(assigns(:cat)).to be_a(Cat)
    end

  end
```

### link up your 'new cat' page 
- in ```index.html.erb``` add a link to ```new.html.erb```
```
<h1>meowtown</h1>
<%= link_to('make a new cat', new_cat_path) %>
<ul>
  <% @cats.each do |cat| %>
    <li>
      <h2><%= cat.name %></h2>
      <img src='<%=cat.image_url%>' />
      <p>lives left: <%= cat.lives %></p>
      <%= link_to('show this cat', cat_path(cat)) %>
    </li>
  <% end %>
</ul>
```

### add '#edit' action
- this is going to render a form allowing us to edit an existing cat
- write specs:
```ruby
  describe "#edit" do

    before do
      @cat = create(:cat)
      get :edit, id: @cat.id
    end

    it { should respond_with(200) }
    it { should render_template(:edit) }
    it "should assign cat with specified id to @cat" do
      expect(assigns(:cat)).to eq(@cat)
    end

  end
```
- build controller action
```ruby
  def edit
    @cat = Cat.find(params[:id])
  end
```
- create ```edit.html.erb```
```ruby
<h1>edit a cat</h1>

<% if @cat.errors.any? %>
    <ul>
      <% @cat.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
    </ul>
<% end %>

<%= form_for :cat, url: cat_path(@cat), method: :patch do |f| %>
  <p>
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </p>
  <p>
    <%= f.label :life_story %><br>
    <%= f.text_area :life_story %>
  </p>
  <p>
    <%= f.label :image_url %><br>
    <%= f.text_field :image_url %>
  </p>
  <p>
    <%= f.submit %>
  </p>
<% end %>

<%= link_to('back', cats_path) %>
```

### create an '#update' action for your edit form 
- we'll make an #update action in our controller for the edit form to submit to:
- write specs:
```ruby
  describe "#update" do

    context "with valid params" do

      before do
        @cat = create(:cat)
        @cat_params = attributes_for(:cat)
        patch :update, { id: @cat.id, cat: @cat_params }
      end

      it { should respond_with(302) }
      it { should redirect_to("/cats/#{@cat.id}")}
      it "should update the attributes for cat" do
        expect(Cat.find_by(@cat_params)).to be_truthy
      end

    end
    
    context "with invalid params" do

      before do
        @cat = create(:cat)
        @invalid_cat_params = { name: "", life_story: "", image_url: "" }
        patch :update, { id: @cat.id, cat: @invalid_cat_params }
      end

      it { should respond_with(400) }
      it { should render_template(:edit) }
      it "should not update the attributes for cat" do
        expect(Cat.find_by(@invalid_cat_params)).to be_nil
      end

    end

  end
```
- build controller action:
```ruby
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to @cat
    else
      render 'edit', status: 400
    end
  end
```

### link your 'edit' page to your 'index'
- in ```index.html.erb```
```
<h1>meowtown</h1>
<%= link_to('make a new cat', new_cat_path) %>
<ul>
  <% @cats.each do |cat| %>
    <li>
      <h2><%= cat.name %></h2>
      <img src='<%=cat.image_url%>' />
      <p>lives left: <%= cat.lives %></p>
      <%= link_to('show this cat', cat_path(cat)) %>
      <%= link_to('edit this cat', edit_cat_path(cat)) %>
    </li>
  <% end %>
</ul>
```
### add cat dying process
- write specs
```ruby
  describe "#show" do

    before do
      @cat = Cat.create(attributes_for(:cat))
      allow(@cat).to receive(:lose_a_life!)
      get :show, id: @cat.id
    end

    it { should respond_with(200) }
    it { should render_template(:show) }
    it "should assign cat with specified id to @cat" do
      expect(assigns(:cat)).to eq(@cat)
    end
    it "should call cat's #lose_a_life! method" do
      @cat.reload
      expect(@cat.lives).to eq(8)
    end

end
```
- add functionality to controller action
```ruby
  def show
    @cat = Cat.find(params[:id])
    @cat.lose_a_life!
  end
```

### done 
here's a summary of the code 
https://gist.github.com/euglazer/cd358acb693e3daa5941
