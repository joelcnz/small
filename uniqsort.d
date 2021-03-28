void main() {
	import std.stdio;
	writeln("Enter input:");
	import std.string: chomp, toLower;
	auto input = readln.chomp;
	import std.algorithm: sort, reverse, uniq;
	import std.conv: to;
	import std.array: array;
	input
		.to!(char[])
		.reverse
		.writeln;
	input
		.array
		.sort!"a.toLower < b.toLower"
		.uniq
		.writeln;
}
