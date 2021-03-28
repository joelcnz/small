auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront)
		if (dg(arr.front))
			arr2 ~= arr.front;

	return arr2;
}

void main() {
	import std.stdio: writeln;
	filt!int(a => a < 40, [35, 38, 41, 12, 21, 4, 32, 59, 68]).writeln;
	import std.string: split;
	import std.algorithm: sort;
	import std.array: array;
	foreach(name; filt!string(a => a[0] == 'J', "Joel Alan Ria Dad Joy Mari Lahtrell Jeremy Timothy".split.sort!"a.length < b.length".array))
		writeln(name);
}
