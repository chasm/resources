# Lecture Notes: Debugging

### some general tips

1. read error messages
  - when something goes wrong, we get an enormous error message with a huge list of files and corresponding line numbers. there is a lot of noise here, but we can filter that noise. look for any files that you recognize, go to the line numbers of those files and read. read slowly -- character by character. your error is likely to be there or in that general vicinity. 
2. google carefully and intelligently
  - use google's search tools, namely, the time filter. potential solutions from several years ago may not be relevant anymore, look at recent search results.
  - use quotes to search an exact phrase (".zlogin:1: command not found: rbenv")
  - Use the minus sign to eliminate results containing certain words
3. don't assume that things work the way they're meant to
4. debug one thing at a time
5. explain your code, slowly, line-by-line, to an inanimate object (see [rubber duck debugging](http://en.wikipedia.org/wiki/Rubber_duck_debugging)). seriously, do this. it works.

### debuggers

suppose we write a method, and it doesn't work, and we don't know why. what do we do? we might try to 'peek' into the method by throwing a few ```puts``` statements around. we run the code, everything explodes, and we get some printouts amongst a sea of error messages that give us a better idea of what our code is actually doing. 

we repeat this process over and over until the printouts start looking like what we want them to look like, and the error messages start to disappear.

but there should be a better way right? there is. it's called a debugger. 

a debugger is a program designed to test and debug other programs. it lets you pause the execution of your code at any line, and while you're paused, you can read and write to any existing variables. while you are in this paused state, you can step through your code one line at a time. this is extremely convenient.

### byebug

a popular ruby debugger is [byebug](https://github.com/deivid-rodriguez/byebug). 

to install byebug on your machine, open terminal and run ```gem install byebug```.

to run byebug on a ruby file:
  1. add ```require 'byebug'``` to the top of that file.
  2. include the word ```byebug``` on whatever line you want your 'pause' the execution of your code. this is called a 'breakpoint'
  3. run your file as you normally would.
  4. use byebug's interface (described below) to debug your code.

### byebug's interface

there are a lot of commands that byebug makes available to you (you can see the full list on [their github](https://github.com/deivid-rodriguez/byebug)), but here's a short list of some important ones:
- list
  - lists lines of code forward from the current line
- next
  - goes to the next line
- step
  - steps inside of a method
- display <variable_name>
  - begins tracking the value of specified variable. if no variable specified, lists all tracked variables
- undisplay <variable_id>
  - stops tracking variable with specified id
- quit
  - quits byebug
- help <command>
  - prints help text regarding the specified command.
- [return key]
  - pressing the return key repeats the last command entered.

### example usage

#### [recurse example](./recurse-example.rb)

we'll use the following example to play around with byebug's command interface. just to be clear, there is nothing significant to debug here! we are only using this as a way to experiment with byebug's interface.

```ruby
require 'byebug'

def recurse(num)
  byebug
  num += 1
  print_money(num)
  recurse(num)
end

def print_money(num)
  puts "$" * num
end

recurse(0)
```

when we run the following example. we see the following:

```
➜  ~  ruby test.rb

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def recurse(num)
    4:   byebug
=>  5:   num += 1
    6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
(byebug) 
```

byebug stops at the line directly below our breakpoint. this line has not yet executed. we can use the ```display``` command to begin tracking ```num```

```
(byebug) display num
1: num = 0
(byebug) 
```

```num``` is now displayed, and is equal to zero, as it should. we can use the ```next``` command to execute the current line, and move the debugger to the next line

```
(byebug) next
1: num = 1

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def recurse(num)
    4:   byebug
    5:   num += 1
=>  6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
(byebug) 
```

```num``` is now 1, and the current line is now line 6.

we can press the return key, to execute the last command (```next```). what do we expect will happen?

```
(byebug) 
$
1: num = 1

[2, 11] in test.rb
    2: 
    3: def recurse(num)
    4:   byebug
    5:   num += 1
    6:   print_money(num)
=>  7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
   11:   puts "$" * num
(byebug) 
```

its moved to line 7. interesting, it doesn't go inside of the ```print_money``` method, it just continues onto the next line of the current method. what if we run the next command again?

```
(byebug) 
1: num = 1

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def recurse(num)
    4:   byebug
=>  5:   num += 1
    6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
(byebug) 
```

it goes to line 5. this makes sense. the last line of the ```recurse``` method calls the ```recurse``` method. so, we end up on line 5 of the currently executing ```recurse``` method. let's run ```next``` one more time. 

```
(byebug) 
1: num = 2

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def recurse(num)
    4:   byebug
    5:   num += 1
=>  6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
(byebug) 
```

```num``` is now 2, as expected, and we're back on line 6 again. this time, we'd like to actually step into the ```print_money``` method. we can do this with the ```step``` command. 

```
(byebug) step
1: num = 2

[5, 14] in test.rb
    5:   num += 1
    6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
=> 11:   puts "$" * num
   12: end
   13: 
   14: recurse(0)
(byebug) 
```

super. now we're inside the ```print_money``` method. ```num``` is still 2. so, if we run ```next``` again, we should see 2 "$" symbols appear on the screen. 

```
(byebug) next
$$
1: num = 2

[2, 11] in test.rb
    2: 
    3: def recurse(num)
    4:   byebug
    5:   num += 1
    6:   print_money(num)
=>  7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
   11:   puts "$" * num
(byebug) 
```

yep, 2 dollar signs. cool.

what if we wanted to change ```num``` to something else? we can set ```num```, as well as any other variable, to anything we want at any time. 

```
(byebug) num = -10000
-10000
(byebug) 
```

we can just type ```num = -10000``` and ```num``` becomes -10000. we can confirm this to ourselves by running ```next``` one more time. 

```
(byebug) next
1: num = -10000

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def recurse(num)
    4:   byebug
=>  5:   num += 1
    6:   print_money(num)
    7:   recurse(num)
    8: end
    9: 
   10: def print_money(num)
(byebug) 
```

and we see that ```num``` is updated. sweet.

we're finished with this example, so let's quit the debugger with the ```quit``` command. 

```
(byebug) quit
Really quit? (y/n) 
```

yes, actually.

```
Really quit? (y/n) y
➜  ~  
```

great.

#### [nested loop example](./nested-loop-example.rb)

in this next, example we have a nested loop. we're using this as an example, because on friday you will be building a sudoku board solver. this solver will likely involve lots of nested loops. your sudoku board may be represented as an array of 'rows', with each 'row' being an array of 'cells'. additionally, each cell may have an array of 'potential_values'.

in this implementation our board is represented as an array of arrays of arrays. that's a lot of layers. if things break (and they will), it may be a bit hard to debug. there's a lot to keep track of, but we can offload that to a debugger.

in this next example, again there is nothing significant to debug. we're just using this bit of code to explore the functionality of byebug.

```ruby
require 'byebug'

def print_money(num)
  puts "$" * num
end

5.times do |i|
  5.times do |j|
    5.times do |k|
      byebug
      print_money(i*j*k)
    end
  end
end
```

when we run this code, we get:

```
➜  ~  ruby test.rb 

[5, 14] in test.rb
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
    9:     5.times do |k|
   10:       byebug
=> 11:       print_money(i*j*k)
   12:     end
   13:   end
   14: end
(byebug) 
```

immediately, we can use the ```display``` command to start tracking ```i```, ```j```, and ```k```. this way, we will always know in what iteration we are in, in our nested loop. 

```
(byebug) display i
1: i = 0
(byebug) display j
2: j = 0
(byebug) display k
3: k = 0
(byebug) 
```

now, let's run ```next``` several times 

```
(byebug) 
1: i = 0
2: j = 3
3: k = 4

[5, 14] in test.rb
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
    9:     5.times do |k|
   10:       byebug
=> 11:       print_money(i*j*k)
   12:     end
   13:   end
   14: end
(byebug) 
```

at the top, we can see our displayed variables, ```i```, ```j```, and ```k```. 

at this instant in time, our innermost loop is just about to complete. ```k``` is 4. what do we expect will happen when this next line executes?

```
(byebug) 

*** NameError Exception: undefined local variable or method `k' for main:Object

1: i = 0
2: j = 4
3: k = nil

[4, 13] in test.rb
    4:   puts "$" * num
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
=>  9:     5.times do |k|
   10:       byebug
   11:       print_money(i*j*k)
   12:     end
   13:   end
(byebug) 
```

```i``` is still 0. ```j``` has increased from 3 to 4. ```k``` is now nil. we get a little error message at the top saying that ```k``` is undefined. this is true. since we've just exited the 'k' times loop, ```k``` is currently undefined.

but, if we run ```next``` one more time. 

```
(byebug) next
1: i = 0
2: j = 4
3: k = 0

[5, 14] in test.rb
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
    9:     5.times do |k|
   10:       byebug
=> 11:       print_money(i*j*k)
   12:     end
   13:   end
   14: end
(byebug) 
```

```k``` is defined once more, and has been reset to ```0```. 

now, let's step into the ```print_money``` method

```
(byebug) step
*** NameError Exception: undefined local variable or method `i' for main:Object

*** NameError Exception: undefined local variable or method `j' for main:Object

*** NameError Exception: undefined local variable or method `k' for main:Object

1: i = nil
2: j = nil
3: k = nil

[1, 10] in test.rb
    1: require 'byebug'
    2: 
    3: def print_money(num)
=>  4:   puts "$" * num
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
    9:     5.times do |k|
   10:       byebug
(byebug) 
```

now, ```i```, ```j```, and ```k``` are all undefined. and of course they are. we are in a new method with its own scope. it doesn't know about these variables. but, we've passed the method a ```num```. 

let's display ```num```

```
(byebug) display num
6: num = 0
(byebug) 
```

```num``` is 0, because ```i * j * k = 0 * 4 * 0 = 0``` when it was passed in as ```num```. cool, and if we ```next``` again ...

```
(byebug) next

*** NameError Exception: undefined local variable or method `num' for main:Object

1: i = 0
2: j = 4
3: k = 1
6: num = nil

[5, 14] in test.rb
    5: end
    6: 
    7: 5.times do |i|
    8:   5.times do |j|
    9:     5.times do |k|
=> 10:       byebug
   11:       print_money(i*j*k)
   12:     end
   13:   end
   14: end
(byebug) 
```

```num``` is now undefined, and ```i```, ```j```, and ```k``` are now defined. 

great.
