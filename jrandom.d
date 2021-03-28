import std.stdio;
import std.random;

void main() {
	foreach(x; 0 .. 30)
		writeln(uniform!"[]"(1, 10));
}
