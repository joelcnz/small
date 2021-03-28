auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; !arr.empty; arr.popFront)
		if (dg(arr.front))
			arr2 ~= arr.front;

	return arr2;
}

void main() {
	import std.stdio: writeln;
	import std.algorithm: sort;
	import std.array: array;
	writeln(filt!int(a => a < 40, [35,36,38,41,59,68,12,21,4]).
								  sort!"a < b".array);
}
