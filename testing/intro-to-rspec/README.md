# intro to rspec

we're going to TDD our way through the orm-todos-part-1 challenge.

we'll create a task model, and a task controller, so that the following driver code in our ```todo.rb``` file will run:

```ruby
require_relative 'config/application'
require_relative 'app/controllers/tasks_controller.rb'

user_input = ARGV
command = user_input.shift
params = user_input.join(" ")

case command
  when "list" then TasksController.print_list!
  when "add" then TasksController.add_to_list!(params)
  when "delete" then TasksController.delete_from_list!(params.to_i)
  when "tick" then TasksController.tick!(params.to_i)
  when "untick" then TasksController.untick!(params.to_i)
  else TasksController.render!("available commands: list, add <description>, delete <id>, tick <id>, untick <id>")
end
```

this ```todo.rb``` file functions like a router. it listens for user input via ```ARGV```, and depending on what we say, it will redirect to an appropriate controller action.

it is immediately apparent that we need a controller with the following methods:

```ruby
require_relative '../../config/application.rb'
require_relative '../../app/views/console.rb'

class TasksController

  def self.print_list!
  end

  def self.add_to_list!(description)
  end

  def self.delete_from_list!(id)
  end

  def self.tick!(id)
  end

  def self.untick!(id)
  end

end

```