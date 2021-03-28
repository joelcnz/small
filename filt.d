void filt(T)(bool function(T) fn,T[] arr) {
	foreach(const a; arr)
		if (fn(a)) {
			import std.stdio: writeln;
			writeln(a);
		}
}

void main() {
	import std.algorithm: sort;
	import std.range: array;
	filt!int(a => a < 40, [21, 32, 35, 12, 4, 38, 41, 68, 59].sort!"a > b".array);

	import std.stdio: writeln;
	writeln([21, 32, 35, 12, 4, 38, 41, 68, 59].sort!"a > b");
}