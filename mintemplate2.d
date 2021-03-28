//not work (maybe too older version of D)!

import std.stdio;

auto min(T...)(T x) {
	static if (x.length > 2)
		return min(min(x[0], min[1]), x[2 .. $]);
	else
		return x[0] < x[1] ? x[0] : x[1];
}

void main() {
	auto x = min(1,2,3);
	writeln("1 2 3 - x=", x);
}
