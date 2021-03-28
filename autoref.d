//#auto ref not needed
import std.stdio;

auto ref square(T)(auto ref T x) { return x * x; } //#auto ref not needed

void main() {
	// auto ref is for being able to change a variable while still being able to put in magic numbers etc too.


	int y = 10;
	3.square; // => 9
	y.square; // => 100

	writeln("3 * 3 = ", 3.square);
	writeln("y = ", y, ": y * y = ", y.square);
}
