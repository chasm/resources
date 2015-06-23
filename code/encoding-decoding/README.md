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

## [converting binary to integer](./code-examples/binary-to-integer.js)

we'll do one more example. here, we'll write a function that converts binary to integer.


### a brief aside on binary

in case you don't already know, binary is a way of representing a number as a sequence of zeros and ones. you've probably seen it before. for example, ```10011110``` is the binary representation of ```158```.

binary works like this:

each digit (bit) in a binary integer has a power of 2 associated with it.

the right-most bit is associated with ```2 ^ 0``` which evaluates to 1. 

the second right-most bit is associated with ```2 ^ 1``` which evaluates to 2.

this pattern repeats as we go from right to left, with the associated power of 2 incrementing by 1 with each successive bit.

```
2^7 2^6 2^5 2^4 2^3 2^2 2^1 2^0
128  64  32  16   8   4   2   1
```

great. so what's the difference between 1 and 0? 

the value of the bit (either 1 or 0) is a multiplier. it determines whether we add that bit's associated power of 2 to our resultant number. if we get a 1, we add that number. if we get a zero, we exclude it from the sum.

let's use the following binary integer as an example:

```
10010010
```

and we'll add the associated powers of 2 above for reference:

```
2^7 2^6 2^5 2^4 2^3 2^2 2^1 2^0
128  64  32  16   8   4   2   1
-------------------------------
 1   0   0   1   0   0   1   0
```

multipling each bit with its corresponding power of two, we get:

```
(1 * 128) + (0 * 64) + (0 * 32) + (1 * 16) + (0 * 4) + (1 * 2) + (0 * 1) = 128 + 16 + 2 = 146
```

it's a clever way of representing numbers isn't it?

### let's build a binary decoder

okay, now that we understand binary, we should be able to build something which converts from binary to integers.

let's call that method ```binToInt``` and give it a single input ```bin```


```javascript
function binToInt (bin) {
  
}
```

and we'll write some tests, so we know when things are working and when things aren't

```javascript
function binToInt (bin) {
  
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

now, we'll write some pseudocode, keeping in mind the 'human' process we used to decode binary to integer.

that 'human' process was a bit like this:

```
- given a binary integer, we:
  - initialize sum as 0
  - go through each bit
    - find its associated power of 2
    - multiply associated power of 2 by value of bit (1 or 0)
    - add the product to the sum
  - return sum
```

we'll have to add a few more steps, though. if we want to use javascript to iterate through our binary sequence, we need to turn it into something which can be iterated through.

we can't iterate through an integer, but we can iterate through an array of integers. so we'll add an additional step to our algorithm.

```
- given a binary integer, we:
  - initialize sum as 0
  - convert binary integer to an array of bits
  - go through each bit in bitArray
    - find its associated power of 2
    - multiply associated power of 2 by value of bit (1 or 0)
    - add the product to the sum
  - return sum
```

and again, we'll do the easiest bits first

```javascript
function binToInt (bin) {
  var sum = 0;

  // convert binary integer to an array of bits

  // go through each bit in bitArray
    // find its associated power of 2
    // multiply associated power of 2 by value of bit (1 or 0)
    // add the product to the sum

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

converting a binary integer to an array of bits will take a few steps, and we don't want to clutter up our ```binToInt``` function with code, so we'll create a separate function to do this. we'll call that function ```splitIntToArray``` and it will take a single argument ```integer```

```javascript
function splitIntToArray (integer) {

}
```

and we'll write a few tests:

```javascript
function splitIntToArray (integer) {

}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

why didn't we just do ```console.log(expectedArray === array)```?

in javascript, we can't compare arrays like this. to compare two arrays, we need to go through each element of both and compare them side by side.

anyways, we'll write some pseudocode:

```javascript
function splitIntToArray (integer) {
  // convert integer to string
  // split string into array of chars
  // convert each char into an integer
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

we can't natively 'split' an integer into an array of digits using javascript. we can however, split strings into an array of chars using the ```.split('')``` method.

so let's first split the integer into a string. we can do this using the ```.toString()``` method.

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  // split string into array of chars
  // convert each char into an integer
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

now let's split the string, using the ```.split('')``` method

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  // convert each char into an integer
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

now we need to convert each element of the array to an integer. we're iterating through the array now, so we need something like a for loop.

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  for (var i = 0; i < array.length; i++) {
    var el = array[i];
    // convert el into an integer
    // put integer in array[i]
  }
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

in javascript, you can convert a string into an integer by adding a '+' in front of it. kind of weird, lol. but it works. javascript has a few of these quirks.

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  for (var i = 0; i < array.length; i++) {
    var el = +array[i];
    // put integer in array[i]
  }
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

and then we place it back in the array

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  for (var i = 0; i < array.length; i++) {
    array[i] = +array[i];
  }
  // return converted array
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

cool. finally, we return the converted array:

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  for (var i = 0; i < array.length; i++) {
    array[i] = +array[i];
  }
  return array;
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

and a bit of refactoring ...

```javascript
function splitIntToArray (integer) {
  var array = integer.toString().split('');
  for (var i = 0; i < array.length; i++) {
    array[i] = +array[i];
  }
  return array;
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}
```

we'll use our new function in ```binToInt``` now:

```javascript
function splitIntToArray (integer) {
  var array = integer.toString().split('');
  for (var i = 0; i < array.length; i++) {
    array[i] = +array[i];
  }
  return array;
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}

function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);

  // go through each bit in bitArray
    // find its associated power of 2
    // multiply associated power of 2 by value of bit (1 or 0)
    // add the product to the sum

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

and we'll use a for loop to iterate through bitArray and find each bit

```javascript
function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);

  for (var i = 0; i < bitArray.length; i++) {
    var bit = bitArray[i];
    // find its associated power of 2
    // multiply associated power of 2 by value of bit (1 or 0)
    // add the product to the sum
  }  

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

how do we keep track of the power? well, if we're iterating through the array from left to right, power is going to start at ```bitArray.length - 1``` and decrement by 1 every iteration

we can add a few things in our for loop to account for this:

```javascript
function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);

  for (var i = 0, power = bitArray.length - 1; i < bitArray.length; i++, power--) {
    var bit = bitArray[i];
    // find its associated power of 2
    // multiply associated power of 2 by value of bit (1 or 0)
    // add the product to the sum
  }  

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

we can use ```Math.pow(base, exp)``` to compute the power of two

```javascript
function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);

  for (var i = 0, power = bitArray.length - 1; i < bitArray.length; i++, power--) {
    var bit = bitArray[i];
    var powerOfTwo = Math.pow(2, power);
    // multiply associated power of 2 by value of bit (1 or 0)
    // add the product to the sum
  }  

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

and the last parts are very easy:

```javascript
function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);

  for (var i = 0, power = bitArray.length - 1; i < bitArray.length; i++, power--) {
    var bit = bitArray[i];
    var powerOfTwo = Math.pow(2, power);
    sum += powerOfTwo * bit
  }  

  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

and a bit of refactoring

```javascript
function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);
  for (var i = 0, power = bitArray.length - 1; i < bitArray.length; i++, power--) {
    sum += Math.pow(2, power) * bitArray[i]
  }
  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

and our completed code!

```javascript
function splitIntToArray (integer) {
  var string = integer.toString();
  var array = string.split('');
  for (var i = 0; i < array.length; i++) {
    array[i] = +array[i];
  }
  return array;
}

var array = splitIntToArray(10011001);
var expectedArray = [1,0,0,1,1,0,0,1];
for (var i = 0; i < expectedArray.length; i++) {
  console.log(expectedArray[i] === array[i])
}

function binToInt (bin) {
  var sum = 0;
  var bitArray = splitIntToArray(bin);
  for (var i = 0, power = bitArray.length - 1; i < bitArray.length; i++, power--) {
    sum += Math.pow(2, power) * bitArray[i]
  }
  return sum;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);
console.log(binToInt(10011110) === 158);
```

with tests passing:

```
➜  encoding-decoding git:(encoding-decoding) ✗ node code-examples/binary-to-integer.js
true
true
true
true
true
true
true
true
true
true
true
true
true
```