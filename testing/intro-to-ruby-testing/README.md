run through this [slide deck](http://enspiral-dev-academy.slides.com/enspiral-dev-academy/intro-to-ruby-testing)
  - slide 2: show the wrong way to code
  - slide 3: show the right way to code -- small single purpose methods with clear i/o. test at the seams. if each method works, then the collection of all methods will work too.
  - slide 4: talk about the TDD process, and how it differs from how we usually start coding
  - slide 5: talk about the different ways we can test the output of a method. show 'assert' test helpers, explain in detail to students.

go through the [code examples](./code-examples)
  - show bingo_script.rb, explain what our code is supposed to do.
  - show bingo.rb, explain that none of it is yet built
  - show bingo_spec.rb, introduce our tests. take the pseudocode already there, and work with students to start converting it to tests. After writing a test, write code to pass the test. Once the test passes, refactor the code. Continue until finished, and once finished run bingo_script.rbb
  - if you need, solutions are in the [solutions folder](./solutions)

afterwards, you can point them to this [refactor challenge](https://github.com/enspiral-dev-academy/refactor-this-challenge`)
