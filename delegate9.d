void main() {
	auto dggetPos = (int a) { return a >=0; };
	auto arr = [-1,1,-2,2,-3,-4,3,4];
	import std.stdio;
	writeln("Was: ", arr);
	writeln("Is now: ", filt!int(dggetPos, arr));
}

auto filt(T)(bool function(T) dgIsTrue, T[] arr) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront) {
		if (dgIsTrue(arr[0])) { // eg if (arr[0] >= 0) - see 2nd from the top of this source file
			arr2 ~= arr.front;
		}
	}
	
	return arr2;
}