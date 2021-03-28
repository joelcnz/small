int getInput() {
	import std.stdio: readln;
	import std.string: chomp;
	import std.conv: to;
	
	return readln.chomp.to!int;
}

void main() {
	int guesses = 0;
	import std.random: uniform;
	immutable numberToGuess = uniform!"[]"(1, 1000);
	import std.stdio: writeln, writefln;
	int count;
	writeln("Enter a number between 1 and 1000");
	bool done = false;
	do {
		immutable guess = getInput;
		count += 1;
		import std.math: abs;
		immutable heat = abs(guess - numberToGuess);
		if (guess < numberToGuess)
			writeln("Greater");
		else if (guess > numberToGuess)
			writeln("Lesser");
		else
			writefln("You got it in %s goes!", count),
		done = true;
	} while(! done);
}