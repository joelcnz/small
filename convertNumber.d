// idea for use with money
import std.stdio;

void main() {
	writeln(convertIntTo(350));
}

string convertIntTo(int num) {
	import std.conv;
	writeln("From int: ", num, " to ");
	return text(num / 100, '.', num % 100);
}
