## lecture notes: encoding and decoding

ideas/concepts can have multiple representations. for example 3, "III", and "three" all have the same meaning. Same idea, different encoding.

when we program, oftentimes we need to switch between representations of the same concept. For example, suppose we have two applications -- one written in C# and the other written in Ruby. We'd like the two to be able to talk to eachother. There is an obvious obstacle here. The languages are different. Though they may be talking about the same things, it doesn't matter. Their representations are too different from one another. So what do we do? We can agree on a common representation/language, and use that language when communicating across applications. Commonly, this language is JSON (JavaScript Object Notation).

Anyways, we want to get used to the idea of switching between representations of the same concepts. So let's try a few examples.

## [converting numbers to symbols](./code-examples/numbers-to-symbols.js)

let's invent an alternative representation (we'll call it 'symbol') for our arabic number system, and write a function to translate from arabic to 'symbol'

here is how 'symbol' works:
  - the character ```|``` has a value of 1
  - the character ```=``` has a value of 5
  - characters are additive, i.e. ```=|||``` = ```5 + 1 + 1 + 1``` = ```8```
  - characters are ordered from high to low, going left to right, i.e. 8 is represented as ```=|||``` not ```|||=```

we'll use javascript to write a number-to-symbol converter

let's start by writing some expectations -- some tests. the idea here is that although we might not immediately know how this function will look, we should know exactly how it should behave before writing any of it.

this makes sense right? why would we begin writing a function if we didn't know exactly what it was supposed to do.

we'll start with a name. let's call it: ```numToSymbol```. this name accurately describes its functionality. it is a function that turns numbers into symbols. 

now we need to think about inputs. what is the minimum amount of information that the function needs to work? well -- we definitely need a number, so lets add that as an input.

```javascript
function numToSymbol (number) {
  
}
```

now we need to think about what it returns, given different inputs. this is where we start writing tests.

```javascript
console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
```

if we've written our function correctly, we should get a bunch of 'true's logging to the console when we run our script. if we get a single 'false', we now that our function doesn't work and we know that we have to change something.

we'll leave these tests at the bottom of our script, and use them to check our work as we explore solutions.

```javascript
function numToSymbol(number) {

}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
```
 
let's begin pseudocoding a solution:

```javascript
function numToSymbol(number) {
  // create empty string

  // check how many fives 'fit' inside of number
  // add that many '='s to our output string

  // check what the remainder is, with all fives removed.
  // add that many '|'s to our output string

  // return finished string
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
  
```

let's start with the easiest bit first

```javascript
function numToSymbol(number) {
  var symbol = "";

  // check how many fives 'fit' inside of number
  // add that many '='s to our output string

  // check what the remainder is, with all fives removed.
  // add that many '|'s to our output string

  return symbol;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
```

now, let's figure out that first chunk. we can divide number by 5 and round down, to see how many fives can fit evenly in our number. 

```javascript
function numToSymbol(number) {
  var symbol = "";

  var numOfFives = Math.floor(number / 5);
  // add that many '='s to our output string

  // check what the remainder is, with all fives removed.
  // add that many '|'s to our output string

  return symbol;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");

``` 

now we need to add that many fives to our output string ```symbol```. we can do this easily with a for loop.

```javascript
function numToSymbol(number) {
  var symbol = "";

  var numOfFives = Math.floor(number / 5);
  for (var i = 0; i < numOfFives; i++) {
    symbol += "=";
  }

  // check what the remainder is, with all fives removed.
  // add that many '|'s to our output string

  return symbol;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
``` 

we'll deal with the second chunk now. we can use the modulo operator to find the remainder of a division.

```javascript
function numToSymbol(number) {
  var symbol = "";

  var numOfFives = Math.floor(number / 5);
  for (var i = 0; i < numOfFives; i++) {
    symbol += "=";
  }

  var remainder = number % 5;
  // add that many '|'s to our output string

  return symbol;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
``` 

and we can use another for loop to add that many '|'s to our output string ```symbol```

```javascript
function numToSymbol(number) {
  var symbol = "";

  var numOfFives = Math.floor(number / 5);
  for (var i = 0; i < numOfFives; i++) {
    symbol += "=";
  }

  var remainder = number % 5;
  for (var i = 0; i < remainder; i++) {
    symbol += "|";
  }

  return symbol;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");
``` 

we run our tests, and they all pass:

```
➜  encoding-decoding git:(encoding-decoding) ✗ node code-examples/numbers-to-symbols.js 
true
true
true
true
true
true
true
true
```

- [converting binary to integer](./code-examples/binary-to-integer.js)
  - probably good idea to explain binary before this example.