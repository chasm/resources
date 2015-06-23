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