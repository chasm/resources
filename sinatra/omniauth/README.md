# omniauth with sinatra

## create a user migration and model

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name 
      t.string :email 
      t.string :image_url
      t.timestamps null: false
    end
  end
end
```
- all the above fields we will be able to get from facebook.

## add and configure omniauth-facebook

- in Gemfile
```ruby
gem 'omniauth-facebook'
```

- in environment.rb
```ruby
require 'omniauth-facebook'

configure do
  use OmniAuth::Builder do
    provider :facebook, ENV['APP_ID'], ENV['APP_SECRET']
  end
end
```
- you can add an additional scope parameter to your configuration. this will define what your app will be access from the facebook user. towards the bottom of this [page](https://developers.facebook.com/docs/facebook-login/permissions/v2.3), you'll find a list of 'permission' parameters.

## create and configure a facebook app

- go to https://developers.facebook.com, and create a new 'website' app. 
- add a site url of ```http://localhost/``` to your app.
- go to settings > advanced and scroll down until you find OAuth settings. under 'Valid OAuth redirect URIs' add ```http://localhost:9393/```. save your changes.
- go back to the Dashboard and copy your APP_ID and APP_SECRET down somewhere.

- now, when you start your server, you'll want to first set the environment variables APP_ID and APP_SECRET like so:
```
APP_ID=<your app id> APP_SECRET=<your app secret> shotgun config.ru
```

## prepare controller, user model, and view

```ruby
# this helper returns the current_user stored in the session, if they exist.
# if user not found, returns nil
def current_user
  User.find_by_uid(session[:uid])
end

# this will run before each action in our controller
before do
  # immediately stop and move on if request url contains starts with '/auth'
  pass if request.path_info =~ /^\/auth\//
  # otherwise, redirect to '/auth/facebook' unless a user's uid is already in the session
  # '/auth/facebook' is an action handled by omniauth. it will do all the fancy oauth things.
  # when facebook successfully authenticates you, it'll automatically redirect to '/auth/facebook/callback'
  redirect '/auth/facebook' unless current_user
end

get '/' do
  # set user to the return value of current_user
  @user = current_user
  erb :index
end

# this is the action that fb automatically redirects to when oauth authentication succeeds
get '/auth/facebook/callback' do
  # this grabs all the information on the authenticated fb user that the app is permitted to access
  # you should take a look at this, it's interesting
  auth = env['omniauth.auth']
  # this stores the fb user's uid in the session
  session[:uid] = auth['uid']
  # creates a new user from your auth information, unless a current_user with that information already exists in the DB
  User.create_from_omniauth(auth) unless current_user
  redirect '/'
end

# omniauth automatically redirects here when it errors
get '/auth/failure' do
  # ¯\_(ツ)_/¯ do whatever you want here ¯\_(ツ)_/¯
end
```

```ruby
class User < ActiveRecord::Base

  def self.create_from_omniauth(auth)
    # when called, creates a new User object with properties of the 'auth' object passed in
    self.create(uid: auth['uid'], name: auth.info.name, email: auth.info.email, image_url: auth.info.image)
  end
  
end
```

```ruby
<h1>Hi <%= @user.name %></h1>
<img src="<%= @user.image_url %>" />
<p>your email is: <%= @user.email %></p>
```

## now, start your server and visit http://localhost:9393