void main() {
	import std.stdio;
	auto getPos = (int a) { return a >= 0; };
	auto arr = [-1,0,-5,1,2,-50,-1,3];
	writeln("Was: ", arr);
	writeln("Is now: ", filt!int(getPos, arr));
}

auto filt(T)(bool function(T) dgIfSo, T[] arr) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront) {
		if (dgIfSo(arr[0])) // if dgIfSo a >=0 then append to array
			arr2 ~= arr.front;
	}
	
	return arr2;
}
