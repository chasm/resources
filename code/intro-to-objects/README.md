# Lecture Notes: Intro to objects - LIVE CODING

##Intro
Ruby is an OO language, and as such we can model things as objects.
Four main concepts of OO
1.Abstraction
  -abstraction is simplifying complex reality by modeling classes appropriate to the problem
2.Polymorphism
  -polymorphism is the process of using an operator or function in different ways for different data input.
3.Encapsulation
  -encapsulation hides the implementation details of a class from other objects. Trying to limit what is available to
  other objects
4.Inheritance
  -Forming new classes from previous classes that have already been defined.

##What is an object?
Object is a combination of data and methods.
Lets use a cat as an example.
We will create a cat class to represent a cat in real life

```ruby
class Cat

end
```
The cat's looking a bit sad, so lets give him a name. For us to be able to do this,
We need to do a couple of things
  1.Set initialize method to accept arguments
  2.Set instance variables
  3.attr_reader *double check with students how they are with attr_reader,writer, accessor*
```ruby
class Cat
  attr_reader :name
  def initialize(name)
    @name = name
  end

  end
```

Now we want the cat to be able to do some stuff like purr and walk and talk, and maybe even dress him

###*live coding*

```ruby
class Cat
  attr_reader :name, :energy, :clothes
  def initialize(name)
    @name = name
    @energy = 100
    @clothes = []
  end

  def walk!
      if check_energy
        puts "#{@name} walked out the door"
      else
        puts "feed me"
      end
      @energy -= 25
  end

  def feed(food)
    @energy = 100
    puts "#{name} enjoyed eating the #{food}"
  end

  def dress(clothing)
    @clothes << Clothing.new(clothing)
  end

  def wardrobe?
    @clothes.each{|item| puts item.name}
  end

  def to_s
    "meow meow meow meow meow meow"
  end

  private

  def check_energy
    return true if @energy > 0
  end

end

class Clothing
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

cat = Cat.new("scrappy")
puts cat
cat.walk!
cat.feed("poison")
cat.dress("top-hat")
cat.dress("fedora")
cat.dress("scarf")
cat.dress("Nike AF1 feline purdition")
cat.wardrobe?


```
