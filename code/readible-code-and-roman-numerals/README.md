# readible code and roman numerals lecture

## code readability:
- variable names should exactly reflect their contents
- method names should exactly reflect their functionality
- names can be as long and descriptive as you want -- our computers have way more than enough memory
- if you can think of a simpler name with the same meaning, use that one. minimize jargon
- break large scripts into methods with good names
- in ruby, classes are 'PascalCase', and basically everything else is 'snake_case'
- our methods and variables should be so well-named, and are code so organized, that our code reads close to english and is self-documenting

## roman numerals:
- human beings can easily decode roman numerals to arabic numerals, as long as we have the necessary vocabulary and know the rules/conventions
  ```
    vocabulary
  roman   arabic
    M  ->  1000
    D  ->  500
    C  ->  100
    L  ->  50
    X  ->  10 
    V  ->  5
    I  ->  1

  rules:
    - numbers are additive (III -> 1 + 1 + 1 = 3)
    - large numbers on the left, small numbers on the right (8 -/> IIIV, 8 -> VIII)
  
  also:
    - for now, we will use 'old' roman numerals, where 4 is represented as IIII, not IV, and 9 is represented as VIIII, not IX, etc.
  ```
  
- our roman numeral decoding algorithm in 'human' terms
  
```
# given a 'number'

  # we repeat the following process until 'number' is 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    # 2. find corresponding 'roman' for that 'arabic'
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number

# number = 17
# roman_numeral = ""
# -------------------------
# largest_arabic = 10
# corresponding_roman = "X"
# roman_numeral += "X"
# number -= 10

# number = 7
# roman_numeral = "X"
# -------------------------
# largest_arabic = 5
# corresponding_roman = "V"
# roman_numeral += "V"
# number -= 5

# number = 2
# roman_numeral = "XV"
# -------------------------
# largest_arabic = 1
# corresponding_roman = "I"
# roman_numeral += "I"
# number -= 1

# number = 1
# roman_numeral = "XVI"
# -------------------------
# largest_arabic = 1
# corresponding_roman = "I"
# roman_numeral += "I"
# number -= 1

# number = 0
# roman_numeral = "XVII"
```
- and now, we begin translating our mental processes into code:
```ruby
def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    # 2. find corresponding 'roman' for that 'arabic'
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- lets try number 1:
```ruby
$cipher = {
  1000 => "M",
  500 => "D",
  100 => "C",
  50 => "L",
  10 => "X",
  5 => "V",
  1 => "I"
}

def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    largest_arabic = nil
    $cipher.each do |arabic, roman|
      if arabic / number > 0
        largest_arabic = arabic
        break
      end
    end
    # 2. find corresponding 'roman' for that 'arabic'
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- we're only 1/4 way through the method, and we're already at 7 lines. Ruby methods should be ~5 lines long. Maybe we should abstract this process into an external method?
```ruby
$cipher = {
  1000 => "M",
  500 => "D",
  100 => "C",
  50 => "L",
  10 => "X",
  5 => "V",
  1 => "I"
}

def largest_arabic_in(number)
  $cipher.each do |arabic, roman|
    if arabic / number > 0
      return arabic 
    end
  end
end

def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    largest_arabic = largest_arabic_in(number)
    # 2. find corresponding 'roman' for that 'arabic'
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- and refactor ... 
```ruby
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def largest_arabic_in(number)
  $cipher.each { |arabic, roman| return arabic if arabic / number > 0 }
end

def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    largest_arabic = largest_arabic_in(number)
    # 2. find corresponding 'roman' for that 'arabic'
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- and onto step #2
```ruby
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def largest_arabic_in(number)
  $cipher.each { |arabic, roman| return arabic if arabic / number > 0 }
end

def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    largest_arabic = largest_arabic_in(number)
    # 2. find corresponding 'roman' for that 'arabic'
    corresponding_roman = $cipher[largest_arabic]
    # 3. add that 'roman' to 'roman_numeral'
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- step #3 ... 
```ruby 
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def largest_arabic_in(number)
  $cipher.each { |arabic, roman| return arabic if arabic / number > 0 }
end

def to_roman(number)
  roman_numeral = ""
  while number > 0
    # 1. find largest 'arabic' that we're able to fit inside of 'number'
    largest_arabic = largest_arabic_in(number)
    # 2. find corresponding 'roman' for that 'arabic'
    corresponding_roman = $cipher[largest_arabic]
    # 3. add that 'roman' to 'roman_numeral'
    roman_numeral += corresponding_roman
    # 4. subtract 'arabic' from number
  end
  return roman_numeral
end
```
- and finally, step #4, + remove comments, and refactor
```ruby 
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def largest_arabic_in(number)
  $cipher.each { |arabic, roman| return arabic if arabic / number > 0 }
end

def to_roman(number)
  roman_numeral = ""
  while number > 0
    largest_arabic = largest_arabic_in(number)
    roman_numeral += $cipher[largest_arabic]
    number -= largest_arabic
  end
  roman_numeral
end
```
- is there a better way though? currently we are only adding one roman_numeral per iteration. It would be cool if we could gather the roman numerals in batches.
- instead of "what's the next character?" over and over, we can try asking instead: "how many M's?", "how many D's?", "how many C's?", etc. This is more efficient.
```ruby
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def to_roman(number)
  roman_numeral = ""
  $cipher.each do |arabic, roman|
    count = arabic / number
    roman_numeral += roman
    number -= arabic
  end
  return roman_numeral
end
```
- and a slight refactor:
```ruby
$cipher = { 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 => "X", 5 => "V", 1 => "I" }

def to_roman(number)
  roman_numeral = ""
  $cipher.each do |arabic, roman|
    roman_numeral += arabic / number
    number -= arabic / number
  end
  roman_numeral
end
```
- what about 'actual' roman numerals, where 4 is IV and IX is 9, etc.? turns out this is really easy to accomodate for:
```ruby
$cipher = {1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I"}

def to_roman(number)
  roman_numeral = ""
  $cipher.each do |arabic, roman|
    roman_numeral += arabic / number
    number -= arabic / number
  end
  roman_numeral
end
```

## summary
- divide problems into as many small parts as you can
- divide large methods into smaller methods. 
- your methods should be small and single-purpose.
- name everything well
