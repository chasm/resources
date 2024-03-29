# Outline of Lecture:

[code-example](./code-example)

- Intro Sinatra and Sinatra skeleton
  - Good stepping-stone to Rails
  - Repos will come with Sinatra Skeleton and they can also be cloned from the Sinatra Skeleton repository (search within your organisation)
  - MVC structure
- Getting started on a project
  - Bundle
  - Gemfile
  - Possible gotchas - Bundle Exec, gem versions. Random Sinatra bug (Undefined method 'split' for <String #<random number>) is fixed by putting rack version to 1.5.2. Testing and Development environments.
  - Rake tasks - in particular, generating a model and migration
  - Rake console
- Generate a Model and Migration
- Seed the database using Faker
- Run Shotgun in a new tab, visit the app and see the 'Sinatra doesn't know this Ditty' page
- Create a route
  - Passing info to the view with instance variables
  - Rendering erb
  - Redirecting
- Create a view
  - talk about naming
  - Give examples of <% %> and <%= %> by creating an each loop
- Intro to forms
  - create a form with post method
  - If appropriate, talk about delete and put gotchas (insert a hidden field to get around this)
  - Create a route to deal with the form
- Take questions, requests for clarifications. If appropriate, walk them through the first steps of the first challenge.