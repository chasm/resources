function numToSymbol(number) {
  var output = "";
  var num_of_fives = Math.floor(number / 5);
  for (var i = 0; i < num_of_fives; i++) {
    output += "=";
  }
  var remainder = number % 5;
  for (var i = 0; i < remainder; i++) {
    output += "|";
  }
  return output;
}

console.log(numToSymbol(1) === "|");
console.log(numToSymbol(2) === "||");
console.log(numToSymbol(4) === "||||");
console.log(numToSymbol(5) === "=");
console.log(numToSymbol(7) === "=||");
console.log(numToSymbol(9) === "=||||");
console.log(numToSymbol(10) === "==");
console.log(numToSymbol(12) === "==||");