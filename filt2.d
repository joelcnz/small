void filt(T)(bool function(T) fun, T[] arr) {
	foreach(a; arr)
		if (fun(a)) {
			import std.stdio: writeln;
			writeln(a);
		}
}

void main() {
	import std.algorithm: sort;
	import std.range: array;
	filt!int(a => a < 40, [35,36,41,59,68,32,12,21,4].sort!"a < b".array);
}
