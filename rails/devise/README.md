# Devise

Lecture Notes:

- Visit [Devise's Github](https://github.com/plataformatec/devise)
  - speak briefly on the available modules, their value, and so on.
  - point out the [wiki](https://github.com/plataformatec/devise/wiki)
  - Run through the "Getting Started" section of Devise's Github.
    - open the [example rails app](./example). This is a clean slate that you can do an example devise installation/setup on.
    - add ```gem 'devise'``` to the gemfile and bundle
    - run ```rails generate devise:install``` and show the files/folders that were created
    - follow the instructions in devise's post-installation terminal output. emphasize that this printout needs to be read.
      - add ```config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }``` to /config/environments/development.rb
      - add ```root to: "pages#home``` to routes.rb.
        - mention that we are doing this so that when a user successfully signs in, devise knows where to redirect to. 
      - add flash messages 
        ```
        <p class="notice"><%= notice %></p>
        <p class="alert"><%= alert %></p>
        ```
        to application.html.erb, in the body. 
      - ignore step 4, because we're using rails 4.2.0.
      - skip step 5, but mention that since devise's default views for the user signin/signup pages are quite ugly, we can see + edit the views if we want by running ```rails g devise:views``` 
    - go back to 'getting started' on devise's github page.  
      - run ```rails generate devise user```
        - explain that MODEL is a placeholder for the name of your model. you can name your model whatever you want, but since we're commonly creating a 'user' model with devise, we name it 'user'.
      - talk about devise's helpers, namely, ```before_action :authenticate_user!```, ```user_signed_in?```, and ```current_user```.
  - now that everything is set up, run ```rake db:create``` and ```rake db:migrate```.
  - open the migration, model, and routes files for the devise user, and show them to the students. Explain.
  - create a pages controller, with an action "home". Add a corresponding view called "home.html.erb".
    - in pages#home, put
      ```redirect_to '/users/sign_in' unless user_signed_in?```
    - in home.html.erb, put
      ```
        <h1><%=current_user.email%></h1>
        <%=button_to('sign out', destroy_user_session_path, method: 'delete')%>
      ```
  - start up a server, and walk through the views that we've created.
