// I don't get this
import std.algorithm;
import std.stdio;
import std.range;

auto slidingWindow(R)(R range, int k) {
	return iota(k).map!(i => range.save.drop(i))
		      .array
	              .transposed;
}

void main() {
	auto data = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];
	writeln(data.slidingWindow(3));
}
