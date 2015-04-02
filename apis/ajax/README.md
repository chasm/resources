# AJAX LECTURE

check out the attached code example. its a simple cat server. you can start the server by running ```bundle install``` and then ```shotgun``` inside of ./code-examples. The server should be running on localhost:9393.

the javascript can be found in ./public/js/application.js
the html can be found in ./app/views/index.erb

the lecture should go as follows:
  - hit the cat server at localhost:9393/cats to show students an example json response.
  - make a post request to localhost:9393/cats, with a name and product.

  - explain that ajax is just a way to communicate with a server with javascript. We make a request to the server, get a response from the server, process the response, and use that response to render things on the page. That's literally all that ajax is.
  - point students to $.ajax documentation. explain that it takes a js object as input with a set of key value pairs.
  - walk them through making a get request and post request to the cat server. Ideally, this will be built from scratch in front of the students. If you get lost, you can always refer to the code example.

