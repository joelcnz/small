void main() {
	auto getPos = (int a) { return a >= 0; };
	auto arr = [0,1,-1,2,-2,3,4,-5,6];
	import std.stdio;
	writeln("Was: ", arr);
	writeln("Is now: ", filt!int(getPos, arr));
}

auto filt(T)(bool function(T) dg, T[] arr) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront) {
		if (dg(arr[0]) == true) {
			arr2 ~= arr.front;
		}
	}
	
	return arr2;
}
