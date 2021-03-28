// Numbers to words eg. 1 => one, 12 one-two
import std.stdio;

void main(string[] args) {
	count;
	if (2 == args.length) {
		import std.conv;
		auto numToConvert = args[1].to!int;
		writeln("Your number is: ", convertToWord(numToConvert), " (", numToConvert, ")");
	}
	
	import core.thread;
	foreach(i; 0 .. 12 + 1) {
		Thread.sleep(1.seconds);
		write(i.convertToWord, ' '); stdout.flush;
	}
}

void count() {
	foreach(n; 0 .. 12)
		writeln(n.convertToWord);
}

string convertToWord(int n) {
	if (n < 13) {
		switch(n) {
			default: return "invalid number";
			case 0: return "zero";
			case 1: return "one";
			case 2: return "two";
			case 3: return "three";
			case 4: return "four";
			case 5: return "five";
			case 6: return "six";
			case 7: return "seven";
			case 8: return "eight";
			case 9: return "nine";
			case 10: return "ten";
			case 11: return "eleven";
			case 12: return "twelve";
		}
	}
	
	return "dropped through the net";
}