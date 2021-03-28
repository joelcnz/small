
void main() {
	import std.stdio;
	import std.algorithm;
	import std.range;
	import std.string;

	auto fruits = ["Banana", "Apple", "Pear"];
	auto loudFruits = fruits.map!(a => a.toUpper);

	writeln(fruits);
	writeln(loudFruits);

	fib(1000);
	
	foreach(i, fruit; fruits.enumerate)
		write('(', i, ", ", fruit, ")", i != fruits.length - 1 ? ", " : "");
	writeln;
	
	string name = getInput("Enter your name? ");
	writeln("Hi, ", name, "!");
}

auto getInput(string title) {
	import std.stdio;
	import std.string;
		
	write(title); stdout.flush;

	return readln.chomp;
}

void fib(int count) {
	import std.stdio;

	int a = 0, b = 1;
	while(a < count) {
		write(a, ' ');
		auto t = a + b;
		a = b;
		b = t;
	}
	writeln;
}