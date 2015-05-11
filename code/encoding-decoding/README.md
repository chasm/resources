## encoding and decoding

## lecture notes:

### give brief introduction on encoding/decoding:

ideas/concepts can have multiple representations. for example 3, "III", and "three" all have the same meaning. Same idea, different encoding.

when we program, oftentimes we need to switch between representations of the same concept. For example, suppose we have two applications -- one written in C# and the other written in Ruby. We'd like the two to be able to talk to eachother. There is an obvious obstacle here. Ruby doesn't understand C# and C# doesn't understand ruby. Though they may be talking about the same things, it doesn't matter. Their representations are too different from one another. So what do we do? We can agree on a common representation/language, and use that language when communicating across applications. Commonly, this language is JSON (JavaScript Object Notation).

### live javascript code examples (build completely from scratch with students)

- [converting numbers to symbols](./code-examples/numbers-to-symbols.js)
  - here i've made up a fake representation of numbers. "=" means 5, "|" means 1. the code-example should show how this works.
- [converting binary to integer](./code-examples/binary-to-integer.js)
  - probably good idea to explain binary before this example.