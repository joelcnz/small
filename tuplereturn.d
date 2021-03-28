import std.stdio;
import std.typecons;
import std.conv;

void main() {
	auto t = addTwoNumbers(7);
	writeln(t[0], ' ', t[1]);
}

auto addTwoNumbers(int n) {
	return tuple(n+3, "number" ~ 4.to!string);
}
