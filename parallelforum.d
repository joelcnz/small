// Org: from Why I'm Excited about D (dlang.org - forum)
import std.stdio, std.parallelism;

void main() {
	auto names = [ "Adam Hawkins", "Peter Esselius" ];

	foreach(name; names.parallel) {
		writeln(name);
	}
}
