import std.stdio;
import std.random;

void main() {
	foreach(_; 0 .. 10)
//		writeln(uniform(0,1)); // all zeros
//		writeln(uniform!"[)"(0,1)); // all zeros
//		writeln(uniform!"[]"(int.max, int.max)); // just one big number
		writeln(uniform!"[]"(0, 1)); // both 1 0
//		writeln(uniform!"(]"(0,1)); // all ones
}
