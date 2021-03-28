void main() {
	auto getPos = (int a) {	return a >= 0; };
	
	import std.stdio;
	int[] arr =[1, 2, -20, 3, -50, -34, 4, 6, 7];
	writeln("Prevous arr: ", arr);
	writeln(filt!int(getPos, arr));
}

auto filt(T)(bool function(T) dg, T[] arr ) {
	import std.range;
	T[] arr2;
	for(; ! arr.empty; arr.popFront) {
		if (dg(arr[0]))
			arr2 ~= arr.front;
	}
		
	return arr2;
}
