void main() {
	import std.stdio;
	
	auto getPos = (int a) { return a >= 0; };
	auto arr= [-1, 1, -2, 2, 3, 4,-5];
	writeln(arr);
	writeln(filt!int(getPos, arr));
}

auto filt(T)(bool function(T) dg, T[] arr) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront) {
		if (dg(arr[0])) { // if greater than, or equal to 0
			arr2 ~= arr.front;
		}
	}
	
	return arr2;
}