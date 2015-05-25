# Devise

Lecture Notes:
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
  - <model_name> is a placeholder for whatever you want to name your model. typically, this is 'user' or 'admin'.   
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
  - in home.html.erb, put
      ```
        <h1><%=current_user.email%></h1>
        <%=button_to('sign out', destroy_user_session_path, method: 'delete')%>
      ```
- run ```rails s``` and visit ```localhost:3000```

- For controller testing with devise, check out this link:
https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29
