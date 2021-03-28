void main() {
	import std.stdio;
	auto getPos = (int a) { return a >= 0; };
	auto arr = [-1,-3,-4,1,2,-2,3,4];
	writeln("Was: ", arr);
	writeln("Equal to or greater then 0: ", filt!int(getPos, arr));
	writeln("Less than 0: ", filt!int(a => a < 0, arr));
}

auto filt(T)(bool function(T) dg, T[] arr) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront)
		if (dg(arr[0]))
			arr2 ~= arr.front;
	
	return arr2;
}
