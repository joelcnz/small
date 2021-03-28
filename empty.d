// Need std.array or std.range, for empty
import std.stdio;
import std.string;
//import std.array: empty;
import std.range: empty;

void main() {
	string s;
	if (s.empty)
		writeln("Empty");
}
