import std.stdio, std.algorithm, std.array, std.range;

void main() {
	auto range = [1, 2, 3, 4, 5, 6, 7].array;
	auto rangeq = range.save;
	popFrontN( range, 6 );
	writeln( range );
	range = rangeq;
	auto needle = 5;
	auto found = find( ( popFrontN( range, 0 ), range ), needle ); // don't know what pop thing does
	writeln( found );
}
