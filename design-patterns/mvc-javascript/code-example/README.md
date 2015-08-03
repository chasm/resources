# Instructions

## Personal Project Instructions

For the full introduction to this Personal Project please refer to the [master branch](../../tree/master).

### Setting up the server

This project is built off of the Sinatra Skeleton so it should be familiar. The way to get the server server set up and start it is by running the following commands in the project directory.

* `bundle install`
* `bundle exec rake db:create`
* `bundle exec rake db:migrate`
* `bundle exec rake db:seed`
* `bundle exec shotgun config.ru`

If you can also setup and run the tests with the following command in the project directory:

* `bundle exec rake db:test:prepare`
* `bundle exec rspec`

### The Home Page

The home page (at `get /`) will return a blank page. This blank page will have a a div you can append HTML elements to. You can see this div in the `app/view/index.erb` file. Also, on this home page there is a `<head>` loaded that you can see in the `app/view/layout.erb` file. You will find in this head that it is loading jQuery for you as well as the `public/js/application.js` file.

You will be puttining your project JS code into the `public/js/application.js` file (and any other JS file you want but just be sure to load it in the layout head tag).

### The API

Your server provideds the following HTTP verbs and URLs that you can consume with AJAX calls.


In the `app/controller/customers_controller.rb` file it provides the URLS:

* `get "/customers"`
* This URL will return a list of customers in `JSON`.

* `post "/customers"`
* This URL will try to create a new customer. It will expect data in the format of `{ "customer" => { "name" => "Sam", "email" => "test@example.com", "phone_number" => "111-222-3333" } }`. It will return the saved customer back in `JSON` if successfull and a `400` status if it was not (this could be handled by your `ajax` `failure` handler).

* `put "/customers/:id"`
* This URL will try to update a new customer. It will expect data in the format of `{ "customer" => { "name" => "Sam", "email" => "test@example.com", "phone_number" => "111-222-3333" } }`. It will return the updated customer back in `JSON` if successfull and a `400` status if it was not (this could be handled by your `ajax` `failure` handler).

* `delete "/customers/:id"`
* This URL will try to delete a customer. You need to provide it the `id` in the URL and it will return a `200` success if it can delete the customer and `400` error status if not.


In the `app/controller/notes_controller.rb` file it provides the URLS:

* `get "/customers/:customer_id/notes"`
* This URL will return a list of notes for a specific customer. You must provide it the customer id in the URL. In this case **it will not return data in JSON** instead it will return `HTML` and you must append that HTML to an existing HTML node on your page.

* `post "/customers/:customer_id/notes"`
* This URL will create a new note assocciated with a customer. You must pass the customer id in the URL as well as the note data in the format of `{ "note" => { "content" => "Good customer." } }` It will return the saved note in `JSON` if successful or a `400` error status if not successful.

### Starting Point

1. Go back and read the user stories on the [master branch](../../tree/master).
1. Try and get a list of customers from the server and display them on the page.
