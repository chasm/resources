# Devise + Omniauth Lecture Notes

- visit [Devise's Github](https://github.com/plataformatec/devise) for a thorough overview of available modules.
- visit the [wiki](https://github.com/plataformatec/devise/wiki) for additional information.

## [Getting Started](https://github.com/plataformatec/devise#getting-started)
- add ```gem 'devise'``` to the gemfile and bundle
- run ```rails generate devise:install```
- add ```config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }``` to ```/config/environments/development.rb```
- add ```root to: "<controller_name>#<action_name>``` to routes.rb.
  - we set a 'root' so that devise knows where to redirect to, if the user signs in or signs up correctly. for this example, we'll use ```'pages#home'```
- add flash messages to the body of ```application.html.erb```
```
<body>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
  <%= yield %>
</body>
```
- run ```rails generate devise <model_name>```
  - model_name is a placeholder for whatever you want to name your model. typically, this is 'user' or 'admin'.   
  - this sets up a user migration, user model, and tons of ready-to-use routes for your user.

- run ```rake db:create``` and ```rake db:migrate```. 

- now, anywhere in our code, we can use the following devise helpers:
```ruby 
  before_action :authenticate_user!  # add this to any controller, and it will require a user session to access any of the controller's actions
  
  user_signed_in? # this returns true if a user is stored in the session, otherwise returns false
  
  current_user # returns the user object whose id is stored in the session
```

- create a pages controller, with an action "home". Add a corresponding view called "home.html.erb".
  - at the top of the controller put: ```before_action :authenticate_user!```
  - in home.html.erb, put:
  ```
    <h1><%=current_user.email%></h1>
    <%=button_to('sign out', destroy_user_session_path, method: 'delete')%>
  ```
- run ```rails s``` and visit ```localhost:3000```

- For controller testing with devise, check out this link:
https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29

## Enabling Login with Facebook using Omniauth

below is a brief, practical overview. for more details, you can visit: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

- visit https://developers.facebook.com/ and create a new app.
  - add a site url of ```http://localhost/``` to your app.  
  - copy that app's 'app_id' and 'app_secret' somewhere
  - under settings > advanced > OAuth settings > valid Oauth redirect URIs, add ```http://localhost:3000/```

- add 'omniauth-facebook' to Gemfile
```ruby
gem 'omniauth-facebook'
```

- run:
```
rails g migration AddColumnsToUsers provider uid
rake db:migrate
```

- add to ```config/initializers/devise.rb```
```ruby
config.omniauth :facebook, "YOUR_APP_ID", "YOUR_APP_SECRET"
```

- add to ```app/models/user.rb```
```ruby
devise :omniauthable, :omniauth_providers => [:facebook]
```

- modify ```config/routes.rb``` to include:
```ruby
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
```

- create file ```app/controllers/users/omniauth_callbacks_controller.rb``` and add to it:
```ruby 
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
```

- in ```app/models/user.rb``` add:
```ruby
def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
end
def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
end
```
- restart your server and visit ```localhost:3000```

- if we want, we can also take our name and image from our facebook profile, and add them to our user. to do this, we'll first create 'name' and 'image_url' fields for our users.
  - create a migration
  ```rails g migration AddNameAndImageUrlToUsers```
  - in the new migration, put:
  ```ruby
  class AddNameAndImageUrlToUsers < ActiveRecord::Migration
    def change
      add_column :users, :name, :string
      add_column :users, :image_url, :string
    end
  end
  ```
  - in the user model, add:
  ```ruby
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image_url = auth.info.image
    end
  end
  ```
- now, when a user signs in or signs up with facebook, their facebook name and image_url will be add to their user model. We can display this information on our 'home' page like so:
```ruby
  <h1>welcome <%=current_user.name%></h1>
  <img src='<%= current_user.image_url %>' />
  <%=button_to('sign out', destroy_user_session_path, method: 'delete')%>
```

### done

[code-example](./devise-setup-example)
