int getInput() {
	import std.stdio: readln;
	import std.string: chomp;
	import std.conv: to;
	immutable int guess = readln.chomp.to!int;
	
	return guess;
}

void main() {
	int guesses = 0;
	import std.random: uniform;
	import std.stdio: writeln, write;
	import std.math: abs;
	immutable numberToGuess = uniform!"[]"(1, 1_000);
	printFile("Guess number between 1 and 1_000, inclusive(sp)");
	bool done;
	do {
		immutable guess = getInput;
		guesses++;
		import std.conv: to;
		printFile(guess.to!string, false);
		int nearness = abs(guess - numberToGuess);
		immutable nearnessStr = nearness == 0 ? "boiling" : nearness < 5 ? "very hot" : nearness < 50 ? "hot" : nearness < 100 ? "cool" : "very cool";
		if (guess < numberToGuess)
			printFile("Greater, " ~ nearnessStr);
		else if (guess > numberToGuess)
			printFile("Lesser, " ~ nearnessStr);
		else
			printFile("Got it, " ~ nearnessStr),
			done = true;
	} while(! done);
	import std.conv: to;
	printFile("You answered correctly in " ~ guesses.to!string ~ " guesses.");
	
	import std.file: append;
	import std.conv: text;
	"guess.txt".append(text("Number To Guess: ", numberToGuess, " Number of guesses: ", guesses, "\n"));
}

void printFile(string str, bool print = true) {
	import std.file: append;
	import std.stdio;
	if (print)
		writeln(str);
	append("guesssteps.txt", str~"\n");
}
