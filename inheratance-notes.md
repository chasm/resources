With this snippet of code we can illustrate

a) The syntax of a parent-child definition

b) how a subclass can use the members of a superclass

c) What really happen when we invoke a child constructor. 


```cs

using System;

public class ParentClass
{
    public ParentClass()
    {
        Console.WriteLine("Parent Constructor.");
    }

    public void print()
    {
        Console.WriteLine("I'm a Parent Class.");
    }
}

public class ChildClass : ParentClass
{
    public ChildClass()
    {
        Console.WriteLine("Child Constructor.");
    }

    public static void Main()
    {
        ChildClass child = new ChildClass();

        child.print();
    }
}

```

What will be the output?


With this snippet of code we can illustrate

a) Method overriding (new keyword)

b) How to access parent properties/methods from the child class.

c) casting 

```cs
using System;
 
public class Parent
{
    string parentString;
    public Parent()
    {
        Console.WriteLine("Parent Constructor.");
    }
    public Parent(string myString)
    {
        parentString = myString;
        Console.WriteLine(parentString);
    }
    public void print()
    {
        Console.WriteLine("I'm a Parent Class.");
    }
}
 
public class Child : Parent
{
    public Child() : base("From Derived")
    {
        Console.WriteLine("Child Constructor.");
    }
    public new void print()
    {
        base.print();
        Console.WriteLine("I'm a Child Class.");
    }
    public static void Main()
    {
        Child child = new Child();
        child.print();
        ((Parent)child).print();
    }
}
```

What will be the output?


Can we do that?
```cs
Child child=new Child();
Parent parent= child;
Child child2= (Child) parent;
```
What about that?
```cs
Object parent = new Object();
Child child= (Child) parent;
```

