int add(int a, int b) {
	return a + b;
}

int times(int a, int b) {
	return a * b;
}

//int delegate(int a, int b)
alias int delegate(int, int) math;

void main() {
	import std.stdio;
	writeln(add(3, 4));
	writeln(times(3, 4));
	
	math dadding = delegate(int a, int b) { return a + b; };
	writeln(dadding(3, 4));
	
	math dtimes = delegate(int a, int b) { return a * b; };	
	writeln(dtimes(3,4));
	
	auto dadding2 = delegate(int a, int b) { return a + b; };
	writeln(dadding2(3,4));
	
	auto dtimes2 = delegate(int a, int b) { return a * b; };
	writeln(dtimes2(3,4));
	
	int a, b;
	writeln("Enter two numbers to add together (eg '3 4')");
	readf(" %s %s", &a, &b);
	writeln(a, " + ", b, " = ", dadding(a, b));
}