void main() {
	import std.stdio, std.algorithm;

	string str = "first: second";
	writeln(str.find(": ")); // does compile
	writeln(str.findSkip(": ")); // does't compile
}
