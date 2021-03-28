// Simple sample: how to use delegates within objects

import std.stdio;

// DelegateClass: a class with declared delegate function "printText"
class DelegateClass 
{
  public void delegate(string) printText;
	public void delegate(string,int) printText2;
}

int main()
{
    // Function print
    void print(string text) { writefln(text); }
    void print2(string text,int number ) { writefln(text,number); }

    // Initialize a DelegateClass
    DelegateClass delclass = new DelegateClass();

    // Assign the delegate "printText" to function "print"
    delclass.printText = &print;
		delclass.printText2 = &print2;

    // Call printText to test

    delclass.printText(`Odd person: "HELLO Joel, how old are you today (July 2009)?"`);
    delclass.printText2(`Joel: "Age: %d"`, 30);

    return 0;
}
