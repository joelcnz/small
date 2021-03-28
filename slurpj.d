//Uses a text file

void main() {
	import std.file;
	auto data = slurp!(int, double, string)("slurp.txt", "%s, %s, %s");
	
	import std.stdio;
	
	foreach(d; data)
		writeln(d[0], ", ", d[1], ", ", d[2]);
}
