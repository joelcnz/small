void main() {
	import std.stdio;
	auto getPos = (int a) => a >= 0;
	auto arr = [-1,1,-2,2,-3,3];
	writeln("Was: ", arr);
	writeln("Is now: ", filt!int(getPos, arr));
	writeln("Also: ", filt!int((a) => a < 0, arr));
}

auto filt(T)(bool function(T) dg, T[] arr) {
	import std.range;
	T[] result;
	for(; ! arr.empty; arr.popFront) {
		if (dg(arr[0])) // eg if arr[a] >= 0
			result ~= arr.front;
	}
	
	return result;
}
