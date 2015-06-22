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