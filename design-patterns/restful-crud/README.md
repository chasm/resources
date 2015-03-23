# CRUD + RESTful Routes

[Slide Deck](http://enspiral-dev-academy.slides.com/enspiral-dev-academy/deck-24)

Lecture Notes: 

- Slide 1: Title Slide
- Slide 2: RESTful Architecture
  - Give a trimmed down, practical explanation of REST. In short:
    - an application is divided into resources. Resources are the 'nouns' of a website. Use twitter as an example. What are the nouns? Users, tweets, comments, etc. 
    - resources are accesible by a URI, a path.
    - CRUD operations can be performed on all resources, by specifying an HTTP verb.
      - Briefly explain the HTTP verbs and there CRUD equivalents
- Slide 3: RESTful Routes
  - the combination of HTTP verb with resource URI is a 'route'
  - Use photos as an example of a resource. 
    - outline necessary routes - create a photo, show a photo, edit a photo, delete a photo.
    - outline additional routes - render a form for create photo, render a form for edit photo, show all the photos.
- Slide 4: RESTful Routes cont..
  - show routes in detail. speak about their HTTP verbs, their paths, and their corresponding controller actions.
- Slide 5: Flow Diagram of RESTful Routes
  - walk them through this example flow diagram of an image hosting site. 
  - mention difference between get and post/put/delete requests. Get requests can respond by rendering html. Post/put/delete requests don't. They are intermediary steps, and often redirect to another get route.

- After, can introduce students to POSTMAN.
- If Rubyists want, can hold a quick breakout session where you use sinatra to create all restful routes for a resource. [Sinatra skeleton can be found in the code-examples folder](./code-examples/ruby)
