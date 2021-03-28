// Simple sample: how to use delegates within objects

import std.stdio;

// DelegateClass: a class with declared delegate function "printText"
class DelegateClass 
{
	public void delegate(string) printText;
}

int main()
{
    // Function print
    void print(string text) { writeln("First: ", text); }
	void print2(string text) { writeln("Second: ", text); }

    // Initialize a DelegateClass
    DelegateClass delclass = new DelegateClass();

    // Assign the delegate "printText" to function "print"
    with(delclass)
		printText = &print,
		printText("I walked into the room."),

		printText = &print2,
		printText("I walked out of the room."),
		
		printText = (text) => writeln("What's this? ", text),
		printText("Say, what?");

    return 0;
}
