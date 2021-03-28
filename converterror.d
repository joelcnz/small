void main() {
	import std.stdio, std.conv;

	foreach(n; '0' .. '9' + 1)
		writeln(n, " - ",n.to!char); // 48 - 57 (not 0 - 9)
}