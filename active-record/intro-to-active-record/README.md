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

### /lib 
  - this seems to be a miscellaneous tools directory.

### /spec
  - contains all of our specs.

## let's run through release 0 of the db-drill-student-schema-challenge

### bundle
  - first things first, we need to run ```bundle install```. nothing will work until we install the gems that our app is dependent upon.

### create a database
- create a database using one of our rake tasks: ```rake db:create```

### create a migration and migrate
- what is a migration? short answer: any change to the structure of your database. by structure, we mean things like the addition, modification, or removal of a table, column, etc. 
- [look at the active record docs](http://edgeguides.rubyonrails.org/active_record_migrations.html) to see all the types of migrations you can make, and how you can make them.
- migrations have strict naming conventions. your migration will not run correctly unless everything is naming correctly. 
  - the name of your migration must begin with a time stamp (YYYYMMDDHHMMSS) and end with a brief description of the migration, in snake_case. i.e. ```20150609124800_create_students.rb```
  - the file must contain a ruby class with name exactly equal to your brief description in the filename, but in PascalCase. the class must also inherit from ```ActiveRecord::Migration```
    ```ruby
    require_relative '../config'

    class CreateStudents < ActiveRecord::Migration
      def change
      end
    end
    ```
- in our first migration, we'll create a students table with the following fields:
  <pre>
  ```
    +------------+
    | students   |
    +------------+
    | id         |
    | first_name |
    | last_name  |
    | gender     |
    | birthday   |
    | email      |
    | phone      |
    | created_at |
    | updated_at |
    +------------+
  ```
  <pre>
- following the documentation, we write:
  ```ruby 
  require_relative '../config'

  class CreateStudents < ActiveRecord::Migration
    def change
      create_table :students do |t|
        t.string :first_name
        t.string :last_name
        t.string :gender
        t.date :birthday
        t.string :email
        t.string :phone
        t.timestamps null: false
      end
    end
  end
  ```
    - notice that we don't need to create an 'id' field for the students table. active record does this for you, it knows that all things in the table will have an id and that those ids will start at 1 and forever autoincrement up by 1 for every new row added to the table. 
    - we also notice that we don't need to manually create 'created_at' and 'updated_at' fields with type 'datetime'. instead, we can use ```t.timestamps null:false```. even more, active record will keep update these fields for us. when we create a new 'student', active record sets 'created_at' to the exact time it was created. whenever we update a student object, active record sets 'updated_at' to the exact time it was updated.

- to run our migration, we run: ```rake db:migrate```. 
  - this will run all migrations in the ```db/migrate``` folder, in chronological order (that's why we have timestamps in the filename). additionally, it will only run migrations which have not yet been run.
- run ```rspec spec/migrate_create_table_spec.rb``` to verify that we've done things correctly.
