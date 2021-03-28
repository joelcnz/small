int main() {
	import std.stdio;
	import std.conv;
	import std.algorithm;

	stdin.byLine
	.until!((a) => a.parse!int == 42)
	.each!writeln;

	return 0;
}
