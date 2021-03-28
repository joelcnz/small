import std.stdio;
//import std.conv;

void main(string[] args) {
	import std.string;
	auto data = args[1..$].join;
	long total;
//	import std.ascii;
	//args[0] = "hardwork";
	foreach(c; data) {
		total += (c.toLower - 'a') + 1;
	}
	writeln("Total: ", total);
}

