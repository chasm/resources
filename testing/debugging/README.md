Lecture for Rubyists:

- talk about some common debugging tips:
  - make small, single purpose methods with clear inputs and outputs
  - testing at seams
  - error messages
  - googling carefully and intelligently

- introduce the concept of debuggers and breakpoints and then show them byebug
[byebug documentation](https://github.com/deivid-rodriguez/byebug)

- run through this example. Show them the recursive stack overflow explosion. Then put a break point and keep track of num. show how you can step into the print_money function
[recurse example](./recurse-example.rb)

- run through this example of a 3-d nested loop. Show the same things as before. Explain that this will be a useful tool when doing the sudoku challenge.
[nested loop example](./nested-loop-example.rb)

- there are a lot of commands available with byebug, but these are the important ones.
  - list
  - next
  - break
  - display / undisplay
  - irb
  - quit
  - help [command]

other notes:
  - pressing enter repeats the last command