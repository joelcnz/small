import std.stdio;
import std.random;
import std.conv;

int read_int(string message)
{
    int result;
    write(message, "? ");
	import std.string;
    try {
    result = readln.chomp.to!int; //(&result);
    } catch(ConvException ex) {
        writeln("The data you entered is not a number!");
       return 0; 
    }
    return result;
}


void main()
{
    enum MIN = 1;
    enum MAX = 10;

    immutable number = uniform!"[]"(MIN, MAX);

    writefln("I am thinking of a number between %s and %s.",
             MIN, MAX);

    auto isCorrect = false;
    while (!isCorrect) {
        immutable guess = read_int("What is your guess");
		if (guess < number)
			writeln("Greater");
		else if (guess > number)
			writeln("Lesser");
       	isCorrect = (guess == number);
    }

    writeln("Correct!");
}
