auto filt(T)(bool function(T) delegateFun, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront)
		if (delegateFun(arr.front))
			arr2 ~= arr.front;
	
	return arr2;
}

void main() {
	int[] arr = [35,38,41,32,21,12,4,59,58];
	import std.stdio: writeln;
	import std.algorithm: sort;
	writeln(filt!int(a => a < 40, arr).sort!"a < b");
}
