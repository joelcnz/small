import std.stdio;

bool isOdd(int number) {
	if ( (number & 1) == 1 ) {
		writeln( number, " is Odd.");
		return true;
	}

	writeln(number, " is not an odd number");

	return false;
}

bool isEven(int number) {
	if ((number & 1) == 0) {
		writeln( number, " is even.");
		return true;
	}
	return true;
}

void main() {
	isOdd(1);
	isOdd(3);
	isOdd(2);
	foreach ( n; 0 .. 8 + 1 )
		isEven(n);
}
