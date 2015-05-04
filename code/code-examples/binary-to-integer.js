function binToInt(bin_int) {
  var sum = 0;
  var digitArray = splitIntToArray(bin_int)
  var power = 0;
  while (digitArray.length > 0) {
    var bit = digitArray.pop();
    var amount = Math.pow(2,power) * bit;
    sum += amount;
    power++;
  }
  return sum;
}

function splitIntToArray(integer) {
  var digitArray = ("" + integer).split("");
  for (var i = 0; i < digitArray.length; i++) {
    digitArray[i] = +digitArray[i];
  }
  return digitArray;
}

console.log(binToInt(1) === 1);
console.log(binToInt(11) === 3);
console.log(binToInt(101) === 5);
console.log(binToInt(1110) === 14);