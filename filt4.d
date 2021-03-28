auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	import std.string: toUpper;
	import std.conv: to;
	for(; ! arr.empty; arr.popFront)
		if (dg(arr.front) == true)
			arr2 ~= arr.front[0..1].toUpper ~ arr.front[1..$];
	
	return arr2;
}

void main() {
	import std.algorithm: sort;
	import std.range: array;
	import std.string: split, toUpper;
	auto jnames = filt!string(a => a[0].toUpper == 'J', "Timothy Joel Alan Ria joy jeremy Lahtral".
				  split.sort!((a, b) => a < b).
				  array);

	import std.stdio: writefln;
	import std.range: empty, popFront, front;
	for(; ! jnames.empty; jnames.popFront)
		writefln("%8s", jnames.front);
}
