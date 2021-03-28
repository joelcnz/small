// filter from std is different and not working on my examples that wrok with mine

void main(string[] args) {
	import std.algorithm: filt = filter;
	
	auto arr = [-1,4,7,9,-4,4,6,-7,2,5,-2,2,1];
	import std.stdio: writeln;
	writeln(jfilt!int(arr, a => a < 0));
	writeln(filt!(a => a < 0)(arr));
	
	import std.string: split;
	auto arr2 = "Joel Alan Timothy Ria Neville Rhondda Mari Jeremy Joy Barry Lahtrell Jacob Bethia".split;
	foreach(e; arr2.jfilt!string(a => a[0] == 'J'))
		writeln(e);
}

auto jfilt(T)(T[] arr, bool function(T) dg) {
	T[] arr2;
	import std.range: empty, front, popFront;
	while(! arr.empty) {
		if (dg(arr.front))
			arr2 ~= arr.front;
		arr.popFront;
	}
	
	return arr2;
}
