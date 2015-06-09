# intro to Active Record

Active Record is an ORM. it allows us to interact with our database using only ruby objects. this means that instead of writing SQL every time we want to interact with the DB, we can instead call pre-built methods on Active Record objects representing rows in our DB that run SQL for us. incredibly convenient, and easy to work with. 

[welcome to Active Record](http://guides.rubyonrails.org/active_record_basics.html)

## our new application framework
```
├── Gemfile
├── Gemfile.lock
├── Rakefile
├── app
│   ├── controllers
│   │    └── students_controller.rb
│   └── models
│       └── student.rb
├── db
│   ├── config.rb
│   ├── data
│   │   └── students.csv
│   └── migrate
│       └── 20121011144238_create_students.rb
├── lib
│   └── students_importer.rb
└── spec
    ├── migrate_create_table_spec.rb
    ├── migrate_timestamps_spec.rb
    ├── student_internationalized_spec.rb
    └── student_spec.rb
```
### Gemfile
  - the type of applications we're going to build from now on will depend on many gems. we can list all the gems we need in the Gemfile, and install every one of them by running ```bundle install``` in the root of the application.
  - to update all gems in the Gemfile, you can run ```bundle update```.
  - if ```bundle``` commands don't work, you probably need to install bundler: ```gem install bundler```

### Gemfile.lock
  - this is auto-generated/updated every time we run ```bundle install``` or ```bundle update```
  - it lists the gems you've installed, their versions, as well as their dependencies.

### Rakefile
  - this file contains a set of 'rake tasks', which are little bits of executable ruby code. each 'task' runs some specialized bit of code, like dropping the database, creating a database, migrating a database, seeding a database, etc.
  - to see all the rake tasks available to you, run ```rake -T```
    - on the left is the command to be run in the terminal
    - on the right is a description of that task
  - you can add rake tasks. just edit the rake file and follow the format of existing rake tasks

### /app
  - the app folder contains our models, controllers, and views. when we start building apps for the web, there will be a views folder containing a bunch of html templates. currently, there is no views folder.

### /db
  - the db folder will contain anything having to do with the database.

### /spec
  - contains all of our specs.