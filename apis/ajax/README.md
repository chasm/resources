# AJAX LECTURE

check out the attached [code example](./code-examples). its a simple cat server. there is a single 'cats' table. cats have a 'name' and a 'product'. 

clone down the code example in ```./code-examples``` and run:
```
bundle
rake db:create
rake db:migrate
rake db:seed
shotgun
```

now visit localhost:9393

our javascript example code can be found [here](./public/js/application.js)
our corresponding html can be found in [here](./app/views/index.erb)

the lecture should go as follows:
  
- use postman to hit the cat server at localhost:9393/cats to show students an example json response.
- use postman to make a post request to localhost:9393/cats, with a name and product.

- explain that ajax is just a way to communicate with a server with javascript. we can use ajax to do what postman does, but in our javascript. we  can make a request to a server, capture the response back from the server, process the response, and use that response to render things on the page. That's literally all that ajax is.

- show students the $.ajax method
```javascript
  $.ajax({
    type: '___',          // 'GET', 'POST', 'PUT', 'DELETE'
    url: '___',           // 'api/path/to/resource'
    data: {               // params object, if server requires params
      param1: value1,     
      param2: value2, 
      ...
    } 
  }).done(function (res) {   // .done executes if request is successful
    // 'res' contains our server's response
  }).fail(function () {   // .fail executes if request is unsuccessful

  });
```
- walk them through making a get request and post request to the cat server. Ideally, this will be built from scratch in front of the students. If you get lost, you can always refer to the code example.

## brief summary of the code example:

cats_controller.rb
```ruby
require 'sinatra/json'

get '/' do
  erb :index
end

get '/cats' do
  json Cat.all
end

post '/cats' do
  name = params[:name]
  product = params[:product]
  if name == "chairvan" && product == "davis" 
    status 400
  else
    @cat = Cat.create(name: params[:name], product: params[:product])
  end
  json @cat
end
```

index.erb
```html
  <h1>Cats</h1>

  <p id='notification'></p>

  <a id='get-cats-button' href='#'>its the cats</a><br>

  <form id='new-cat-form'>
    <input type='text' name='name' placeholder='name'><br>
    <input type='text' name='product' placeholder='product'><br>
    <input type='submit'>
  </form>

  <ul id='cat-container'>
  </ul>

  <a href="#" id="magic">a ton of data about magic</a>
```

application.js
```javascript
$(document).ready(function() {

  // example get request to our server
  $('#get-cats-button').click(function(e) {
    e.preventDefault();
    $.ajax({
      type : 'GET',
      url : '/cats'
    }).done(function (cats) {
      $('#cat-container').empty();
      $.each(cats, function (i, cat) {
        appendCat(cat);
      });
    }).fail(function () {
      console.log("EVERYTHING IS BROKEN AND IM HUNGRY");
    });
  });

  // helper fxn for the above get request example
  function appendCat(cat) {
    $('#cat-container').append(
      '<li>' +
        '<h2>' + cat.name + '</h2>' +
        '<h3>' + cat.product + '</h3>' +
      '</li>'
    );
  }

  // example post request to our server
  $('#new-cat-form').on('submit', function(e) {
    e.preventDefault();
    var $form = $(this);
    $.ajax({
      type: 'POST',
      url: '/cats',
      data: $form.serialize()
    }).done(function (cat) {
        appendCat(cat);
        $('#notification').text('CAT ADD SUCCESS ~ ~ ~ OOOOOO');
        $form[0].reset();
    }).fail(function () {
        $('#notification').html("<img src='http://www.buckybox.com/images/team-joshua-63101086.jpg'> BAD REQUEST");
    });
  });

  // example get request to another server
  $('#magic').on('click', function (e) {
    e.preventDefault();
    $.ajax({
      type: 'GET',
      url: 'http://api.mtgdb.info/cards/random'
    }).done(function (cardObject) {
        alert('check the console!');
        console.log("data on a random magic card from a magic API");
        console.log(cardObject);
    }).fail(function () {
      console.log("EVERYTHING IS BROKEN AND IM HUNGRY");
    });
  });

});
```

