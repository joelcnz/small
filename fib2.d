//#dont seem to need it!
//#why use 'chomp'?
void main() {
	import std.stdio, std.string, std.range, std.conv;

	writeln("12345".take(3)); // this worked

	writeln("Enter number for fib:");
//	auto number = readln.stripRight.to!int; //#why use 'chomp'?
	auto number = readln.dropBackOne.to!int;
	
	writeln(Fib().take(number));
	void print(in string title = "") {
		writeln(title);
		foreach(i, n; Fib().take(number).enumerate(1))
			writeln(i, ". ", n);
	}
	print("User input:");
	number = 10;
	print("First ten:");
}

struct Fib {
	int current = 0;
	int next = 1;

	enum empty = false;
	@property auto front() { return current; }
	void popFront() {
		const nextNext = current + next;
		current = next;
		next = nextNext;
	}
//	auto save() { return this; } //#dont seem to need it!
}

