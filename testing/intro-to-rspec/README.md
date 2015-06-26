# intro to RSpec

[RSpec](http://rspec.info/) is a testing framework for ruby, designed to read like english.

we've written tests previously, and they've looked a bit like this:

```ruby
def average_of(array)
  array.reduce(:+) / array.length
end

test_array = [1,5,3,4,2]
p average_of(test_array) == 3
```

on the right hand side of the ```==``` we have an 'expected' value. on the left hand side of the ```==``` we have our actual value, which is the return value of the fxn we are trying to test. if the two are equal, we get a ```true``` printing to the console. else, we get false.

we can generalize this as:
```ruby
  p actual == expected
```

nearly every test we write can be reduced down to this pattern. "i expect something to equal something else".

in the past, we've built little fxns to run this sort of test, as well as other more specialized tests. we wrote these fxns, because they are a bit more human readible:

```ruby
# does it return true ?
def assert_true(value)
  raise "should return true" unless value == true
  puts "passed!"
end

# does it return false ?
def assert_false(value)
  raise "should return false" unless value == false
  puts "passed!"
end

# is the actual return value equal to the expected return value ?
def assert_equal(actual, expected)
  raise "expected #{expected} but got #{actual}" unless expected == actual
  puts "passed!"
end

# is the return value a member of a certain collection ? 
def assert_membership(item, collection)
  raise "#{item} not present in collection: #{collection}" unless collection.include?(item)
  puts "passed!"
end

# is the return value within a certain range ?
def assert_within_range(item, min, max)
  raise "got #{item}, but should be between #{min} and #{max}" unless item.between?(min,max)
  puts "passed!"
end
```

which would be used like so:

```ruby
assert_true(3 == 3)
assert_false(3 == 2)
assert_equal([0,1,2].length, 3)
assert_membership(2, [0,1,2])
assert_within_range(2, 1, 3)
```

looks alright, pretty easy to read.

this is basically what RSpec is, a collection of test fxns. though, RSpec looks and reads so much nicer.

in RSpec, the above test fxns would look like this:

```ruby
expect(3 == 3).to be_truthy
expect(3 == 2).to be_falsey
expect([0,1,2].length).to eq(3)
expect([0,1,2]).to include(2)
expect(2).to be_between(1, 3)
```

reads like english. 

each of these tests is called an expectation. expectations have matchers.

```
expect(<something>).to <matcher>
```

we've used a few matchers above, but there's quite a few more. you can find some really great documentation on RSpec and RSpec expectations/matchers here: http://www.relishapp.com/rspec/rspec-expectations/v/3-3/docs/built-in-matchers

to familiarize ourselves with RSpec, we're going to TDD our way through the orm-todos-part-1 challenge you worked on this morning.

## code-example

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

this ```todo.rb``` file fxns like a router. it listens for user input via ```ARGV```, and depending on what we say, it will redirect to an appropriate controller action.

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